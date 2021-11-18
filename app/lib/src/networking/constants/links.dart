const String GestationalDiabetesMellitus = "https://www.fhi.no/1";
const String Preeclampsia = "https://www.fhi.no/2";
const String PretermBirth = "https://www.fhi.no/3";
const String Miscarriage = "https://www.fhi.no/4";
const String StillBirth = "https://www.fhi.no/5";
const String PostpartumDepression = "https://www.fhi.no/6";
const String CesareanSection = "https://www.fhi.no/7";
const String PlacentalAbruption = "https://www.fhi.no/8";
const String PlacentaPraevia = "https://www.fhi.no/9";
const String Thrombosis = "https://www.fhi.no/10";
const String HyperemesisGravidarum = "https://www.fhi.no/11";
const String AntepartumHaemorrhage = "https://www.fhi.no/12";

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
