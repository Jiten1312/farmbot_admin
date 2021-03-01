class Category {
  

  List<String> getCategory(String sector) {
    List<String> categories = <String>[];
    if (sector == 'બાગાયત') {
      categories.add('મસાલાઓના અને મિસ્ટ્રેસ');
      categories.add('ફળો');
      categories.add('શાકભાજી');
      categories.add('ડ્રગ અને નશીલી દવાઓના');
      categories.add('ઔષધીય અને સુગંધિત પ્લાન્ટ');
      categories.add('ફૂલો');
      categories.add('બાગાયતી પાક');
    }

    else if(sector == 'ખેત'){
      categories.add('અન્ય');
      categories.add('અનાજ');
      categories.add('તેલીબિયાં');
      categories.add('ઘાસચારાના પાક');
      categories.add('ફાઇબર પાક');
      categories.add('બાજરી');
      categories.add('મસાલાઓના અને મિસ્ટ્રેસ');
      categories.add('કઠોળ');
      categories.add('શાકભાજી');
    }
    else if(sector=='પશુપાલન'){
      categories.add('પશુ');
    }
    
    return categories;
  }
}
