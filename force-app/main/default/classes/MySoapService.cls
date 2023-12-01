global class MySoapService {
    webService static Id createLead(String firstName, String lastName, String company) {
        Lead newLead = new Lead(FirstName = firstName, LastName = lastName, Company = company);
        insert newLead;
        return newLead.Id;
    }
}
