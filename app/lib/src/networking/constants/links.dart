const String GestationalDiabetesMellitus = "https://www.hopkinsmedicine.org/health/conditions-and-diseases/diabetes/gestational-diabetes";
const String Preeclampsia = "https://www.nhs.uk/conditions/pre-eclampsia/";
const String PretermBirth = "https://www.cdc.gov/reproductivehealth/maternalinfanthealth/pretermbirth.htm";
const String Miscarriage = "https://www.plannedparenthood.org/learn/pregnancy/miscarriage";
const String StillBirth = "https://www.cdc.gov/ncbddd/stillbirth/facts.html";
const String PostpartumDepression = "https://www.mayoclinic.org/diseases-conditions/postpartum-depression/symptoms-causes/syc-20376617";
const String CesareanSection = "https://www.mayoclinic.org/tests-procedures/c-section/about/pac-20393655";
const String PlacentalAbruption = "https://www.mayoclinic.org/diseases-conditions/placental-abruption/symptoms-causes/syc-20376458";
const String PlacentaPraevia = "https://www.mayoclinic.org/diseases-conditions/placenta-previa/symptoms-causes/syc-20352768";
const String Thrombosis = "https://www.hopkinsmedicine.org/health/conditions-and-diseases/thrombosis";
const String HyperemesisGravidarum = "https://www.mayoclinic.org/diseases-conditions/morning-sickness/diagnosis-treatment/drc-20375260";
const String AntepartumHaemorrhage = "https://www.bettersafercare.vic.gov.au/clinical-guidance/maternity/antepartum-haemorrhage-assessment-and-management";

get_url(comp) {
  if (comp == "GestationalDiabetesMellitus") {
    return GestationalDiabetesMellitus;
  }
  if (comp == "Preeclampsia") {
    return Preeclampsia;
  }
  if (comp == "PretermBirth") {
    return PretermBirth;
  }
  if (comp == "Miscarriage") {
    return Miscarriage;
  }
  if (comp == "StillBirth") {
    return StillBirth;
  }
  if (comp == "PostpartumDepression") {
    return PostpartumDepression;
  }
  if (comp == "CesareanSection") {
    return CesareanSection;
  }
  if (comp == "PlacentalAbruption") {
    return PlacentalAbruption;
  }
  if (comp == "PlacentaPraevia") {
    return PlacentaPraevia;
  }
  if (comp == "Thrombosis") {
    return Thrombosis;
  }
  if (comp == "HyperemesisGravidarum") {
    return HyperemesisGravidarum;
  }
  if (comp == "AntepartumHaemorrhage") {
    return AntepartumHaemorrhage;
  }
  return "Can't find link";
}
