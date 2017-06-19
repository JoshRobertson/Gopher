package tests;

import java.security.NoSuchAlgorithmException;

import org.junit.Test;

import utils.Password;

/**
 * Test class for the passwod encryption functionality
 * @author Justing
 *
 */
public class Password_tests {

	@Test
	public void testEncryption() {
		
		String password = "password";
		String[] returns = new String[2];
		
		try{
			returns = Password.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			
		}
		
		System.out.println("Encrypted password: " + returns[0]);
		System.out.println("Salt: "+returns[1]);
		System.out.println();
		
		String encrypted = new String();
		
		try {
			encrypted = Password.encrypt(password, returns[1]);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("ReEncrypted password: " + encrypted);
		System.out.println("Hash length: " + encrypted.length());
		System.out.println("Salt length: " + returns[1].length());
		
		if(returns[0].equals(encrypted)) {
			System.out.println("Encryption of passwords match.");
		} else {
			System.out.println("Encryption of passwords does not match.");
		}
	}
	
	@Test
	public void massTestEncryption() {
		
		String[] encryptedPasswords = new String[1000];
		int count = 0;
		for(int index = 0; index < encryptedPasswords.length; ++index) {
			try {
				encryptedPasswords[index] = Password.encrypt("Test1234Testing")[0];
			} catch (NoSuchAlgorithmException e) {
				
			}
		}
		
		System.out.println("Hashed created.");
		
		for(int i = 0; i < encryptedPasswords.length; ++i) {
			for(int j = 0; j < encryptedPasswords.length; ++j) {
				if(j == i) {
					continue;
				} else if(encryptedPasswords[i].equals(encryptedPasswords[j])) {
					System.out.println("Hash conflict");
				}
				++count;
			}
			System.out.println(i + " processed.");
		}
		System.out.println("End of MassTest. Count = " + count);
	}

}
