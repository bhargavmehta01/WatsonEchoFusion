

import java.io.File;
import java.io.IOException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amazonaws.HttpMethod;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.PutItemOutcome;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.util.Tables;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;

import javaQuery.j2ee.tinyURL;

/**
 * Servlet implementation class RegisterServlet2
 */
public class RegisterServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String basekey="pics";
		String bucketname="gradmapics";
		
		String name=request.getParameter("name");
		System.out.println(name);
		String filepath=(String)request.getSession().getAttribute("filepath");
		String serverpath=(String)request.getSession().getAttribute("serverpath");
		System.out.println(filepath);
		
		AmazonS3 s3client = new AmazonS3Client(new ProfileCredentialsProvider("default").getCredentials());
		s3client.setRegion(Region.getRegion(Regions.US_WEST_2));
		
		String key=basekey+"/"+filepath;
		filepath=serverpath+"/"+filepath;

		File f = new File(filepath);
		s3client.putObject(bucketname, key, f);
		
		
	       //System.out.println("heyy1");
		java.util.Date expiration = new java.util.Date();
		long msec = expiration.getTime();
		msec += 1000 * 60 * 60; // 1 hour.
		expiration.setTime(msec);
		             
		GeneratePresignedUrlRequest generatePresignedUrlRequest = 
		              new GeneratePresignedUrlRequest(bucketname, key);
		generatePresignedUrlRequest.setMethod(HttpMethod.GET); // Default.
		generatePresignedUrlRequest.setExpiration(expiration);
		             
		//System.out.println("heyy2");
		URL s = s3client.generatePresignedUrl(generatePresignedUrlRequest);
		System.out.println(s);
		
		tinyURL tU = new tinyURL();
        String getLink = tU.getTinyURL(s.toString());
        
        System.out.println("Short Link:"+getLink);
		
		ProfileCredentialsProvider credentials= new ProfileCredentialsProvider("default");
		AmazonDynamoDBClient dbclient= new AmazonDynamoDBClient(credentials.getCredentials());
		dbclient.setRegion(Region.getRegion(Regions.US_EAST_1));
		String tableName="PersonImageInfo";
		DynamoDB dynamoDB = new DynamoDB(dbclient);

		if(Tables.doesTableExist(dbclient, tableName)){
			System.out.println("table exists");
		}
		
		Table table = dynamoDB.getTable(tableName);
			Item item = new Item()
			    .withPrimaryKey("PersonName", name)
			    .withString("ImageURL", getLink);
			
			PutItemOutcome outcome = table.putItem(item);
	}

}
