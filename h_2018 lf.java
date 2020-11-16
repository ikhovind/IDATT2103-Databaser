/* løsningsforslag eksamen tdat1001 20. des 2018.

	For å få til et kjørbart program og testing av metoder er det lagt til en del 
	ekstra metoder og kode-  dette er markert i koden.
*/
import static javax.swing.JOptionPane.*;
import java.io.*;

class Soppart  implements java.io.Serializable{
	private String navn;
	private String beskrivelse;
	private boolean giftig;  // spiselig, uspiselig, giftig
// 2a)
	public Soppart(Soppart so){
	// her må en tenke komposisjon/ aggregering avh av hva som er beskrevet i oppgave 1
		navn = so.getNavn();
		beskrivelse = so.getBeskrivelse();
		giftig = so.isGiftig();
	}

	public Soppart(String navn, String beskrivelse, boolean giftig){
		this.navn = navn;
		this.beskrivelse =beskrivelse;
		this.giftig = giftig;
	}
// 2b)
	public boolean isGiftig(){return giftig;}
	public String getNavn(){return navn;}
	public String getBeskrivelse(){return beskrivelse;}

// 2c
	public boolean equals(Object obj){  // 3
		if (this == obj) return true;  // 1 
		if (obj instanceof Soppart){ //1 
			Soppart tmp = (Soppart)obj;  // 1
			if (tmp.getNavn().equals(this.getNavn())) return true;  // 1
		}
		return false;
	}

// 2d)
// kan her bruke string.matches, og andre søke-metoder..
	public boolean sok(String sokeStreng){
		if (beskrivelse.indexOf(sokeStreng) >= 0){
			return true;
		}
		return false;
	}
		
	public String toString(){
		String g = "Giftig";
		if (!giftig) g = "Matsopp";
		return navn + " " + beskrivelse  + " " + g;
	}
}

class Soppregister  implements java.io.Serializable{
//3a
	private Soppart[] soppRegister;
	private int antallReg = 0;
	private final int UTVID_FAKTOR = 10;

//3b
	public Soppregister(int maks){
		soppRegister = new Soppart[maks];
	}
	
//3c
	public boolean regNySoppart(Soppart nySoppart){
		if (nySoppart != null && !regFraFor(nySoppart)){
			if (antallReg == soppRegister.length){ // alt bruk antallReg%UTVID_FAKTOR == 0
				utvidTabell();
			}
			soppRegister[antallReg] = new Soppart(nySoppart);
			antallReg++;
			return true;
		}
		return false;
	}

	// utivd tabell med x antall plasser
	private void utvidTabell(){
		Soppart[] nyTab = new Soppart[soppRegister.length + UTVID_FAKTOR];
		for (int i=0; i<antallReg;i++){
			nyTab[i] = soppRegister[i];
		}
		soppRegister = nyTab;
		System.out.println("inni utvid");
	}

	// sjekker om soppart finnes i registret fra foer
	private boolean regFraFor(Soppart so)
	{
		if (so != null){
			for (int i=0; i<antallReg; i++){
				if (soppRegister[i].equals(so)) return true;
			}
			return false;
		}
		return false;
	}

//3d
	public Soppart[] alleMatsopper(){
		Soppart[] tmp = new Soppart[antallReg];
		int antallMatsopper = 0;
		for (int i=0; i<antallReg; i++){
			if (!soppRegister[i].isGiftig()){
				tmp[antallMatsopper] = new Soppart(soppRegister[i]);
				antallMatsopper++;
			}
		}
		if (antallMatsopper<antallReg){
			Soppart[] res = new Soppart[antallMatsopper];
			for (int i=0; i<antallMatsopper; i++){
				res[i] = tmp[i];
			}
			return res;
		} else {
			return tmp;
		}
	}
	
//3e
	public String toString(){
		String res ="Registrerte Sopparter:\n";
		for (int i=0; i<antallReg; i++){
			res += i+1 + ": " + soppRegister[i] + "\n";
		}
		return res;
	}

	
//3f
	public String sokEtterBeskrivelse(String sokeStreng){
		String res = "Søk etter " + sokeStreng + " ga følgende resultat: \n";
		boolean funnet = false;
		for (int i=0; i<antallReg; i++){
			if (soppRegister[i].sok(sokeStreng)){
				res += soppRegister[i] + "\n";
				funnet = true;
			}
		}
		if (!funnet) res += "Ingen registrerte sopparter matcher søkestreng";
		return res;
	}



// ikke spurt etter
	public Soppart[] alleGiftige(){
		Soppart[] tmp = new Soppart[antallReg];
		int antallGiftige = 0;
		for (int i=0; i<antallReg; i++){
			if (soppRegister[i].isGiftig()){
				tmp[antallGiftige] = new Soppart(soppRegister[i]);
				antallGiftige++;
			}
		}
		if (antallGiftige<antallReg){
			Soppart[] res = new Soppart[antallGiftige];
			for (int i=0; i<antallGiftige; i++){
				res[i] = tmp[i];
			}
			return res;
		} else {
			return tmp;
		}
	}
	
}

class Eksamen2018_1ing{
// ikke spurt etter
	public static boolean skrivRegTilfil(String filnavn, Soppregister register){
		try(FileOutputStream utstrom = new FileOutputStream(filnavn);
			ObjectOutputStream ut = new ObjectOutputStream(utstrom)){
			ut.writeObject(register);
			//ut.close();
			return true;
		}catch(IOException ioe){
			System.out.println("IO-feil (skrivRegTilFil())");
		}catch (Exception e){
			System.out.println("Noe som ikke har med IO er feil(skrivRegTilFil()");
		}
		return false; // kommer kun hit naar noe har feilet
	}
// 4a
	public static Soppregister lesRegFraFil(String filnavn){
		try (FileInputStream innstrom = new FileInputStream(filnavn);
			ObjectInputStream inn = new ObjectInputStream(innstrom)) {
			Soppregister register = (Soppregister)inn.readObject();
			inn.close();
			return register;
		}catch(FileNotFoundException e){
			System.out.println("Fil ikke funnet! (lesRegFraFil())");
		}catch(EOFException e){
			System.out.println("Fil funnet, men tom! (lesRegFraFil())");
		}catch(IOException ioe){
			System.out.println("IO-feil (lesRegFraFil())");
		}catch (Exception e){
			System.out.println("Noe som ikke har med IO er feil. (lesRegFraFil())");
		}
		return null; // kommer kun hit naar noe har feilet
	}

// ikke spurt etter
	public static Soppregister opprettNyttRegister(){
		Soppart s1 = new Soppart("Rød fluesopp", "Rød sopp med prikker. Du finner den i skog med bjørk og gran.", true);
		Soppart s2 = new Soppart("Grønn fluesopp", "Hattdiameter 4 - 12 cm. Stilkhøyde 7 - 15 cm. Grønn sopp. Næringsrik løvskog med eik, men ogsæ med bøk og hassel. ", true);
		Soppart s3 = new Soppart("Kantarell", "Hattdiameter 3 - 10 cm. Stilkhøyde 3 - 8 cm. Hele soppen er eggeplommegul, kjøttfull og traktformet med gaffelgrenete nedløpende ribber. Trives best i moserik blåbærgranskog og i gammel bjørkeskog.", false);
		Soppart s4 = new Soppart("Kongesjampinjong", "Hattdiameter 10 - 40 cm. Stilkhøyde 10 - 20 cm. Hatten er først nesten kulerund med avflatet topp, senere mer hvelvet. Næringsrik jord i hager og parker.", false);

		Soppregister register = new Soppregister(4);
		register.regNySoppart(s1);
		register.regNySoppart(s2);
		register.regNySoppart(s3);
		register.regNySoppart(s4);
		return register;
	}

	public static void main(String[] args){

		String filnavn = "soppregister.ser";
		Soppregister register = lesRegFraFil(filnavn);
		if (register == null){
			register = opprettNyttRegister();  // for testformål
		}

		String[] muligheter = {"List alle", "List matsopper", "List giftsopper", "Legg til ny", "Søk", "Avslutt"};
		final int LIST_ALLE = 0;
		final int LIST_MATSOPPER = 1;
		final int LIST_GIFTIGE = 2; // ikke spurt etter
		final int REG_SOPP = 3;
		final int SOK = 4;
		final int AVSLUTT = 5;

		int valg = showOptionDialog(null, "Velg", "Eksamen des 2018",  YES_NO_OPTION, INFORMATION_MESSAGE, null, muligheter, muligheter[0]);
				while (valg != AVSLUTT){
					switch (valg){
						case LIST_ALLE:
						if (register != null){
							showMessageDialog(null,register);
							System.out.println(register);
						} else showMessageDialog(null, "register eksisterer ikke");
						break;
// 4c - aktivitetsdiagram
						case LIST_MATSOPPER:
						if (register != null){
							Soppart[] matsopper = register.alleMatsopper();
							if (matsopper != null){
								String res = "Alle registrerte matsopper:\n";
								for (int i=0; i<matsopper.length; i++){
									res += matsopper[i] + "\n";
								}
								showMessageDialog(null,res);
							} else showMessageDialog(null, "Ingen matsopper funnet");
						} else showMessageDialog(null, "register eksisterer ikke");
						break;

						// ikke spurt etter
						case LIST_GIFTIGE:
						if (register != null){
							Soppart[] giftigeSopper = register.alleGiftige();
							String res = "Alle giftige registrerte sopparter:\n";
							for (int i=0; i<giftigeSopper.length; i++){
								res += giftigeSopper[i] + "\n";
							}
							showMessageDialog(null,res);
						} else showMessageDialog(null, "register eksisterer ikke");
						break;
// 4b)
						case REG_SOPP:
							String navn = showInputDialog("Navn: ");
							String beskrivelse = showInputDialog("Beskrivelse: ");
							boolean giftig = false;
							int giftigLest = showConfirmDialog(null, "Giftig?", "Soppkontrollen", YES_NO_OPTION);
							if (giftigLest == YES_OPTION) giftig= true;
							Soppart s = new Soppart(navn, beskrivelse, giftig);

							boolean ok = register.regNySoppart(s);
							if (ok) showMessageDialog(null, "Sopp registrert");
							else showMessageDialog (null, "Noe gikk galt");
							break;

						case SOK:
							String sokeStreng = showInputDialog("Hva vil du søke etter? ");
							String utskrift = register.sokEtterBeskrivelse(sokeStreng);
							showMessageDialog(null, utskrift);
							break;

						default: break;
					}
					valg = showOptionDialog(null, "Velg", "Eksamen des 2018", YES_NO_OPTION, INFORMATION_MESSAGE, null, muligheter, muligheter[0]);
				}
		skrivRegTilfil(filnavn,register);
	}
}