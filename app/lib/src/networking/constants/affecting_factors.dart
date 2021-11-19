//Explination
//List<List<String>> Complication = [[Changeable Factors], [Unchangeable Factors]];
//Factors found in risk calculation in Server
//epr/services/complication_name.py
const List<List<String>> GestationalDiabetesMellitus = [
  ["BMI pre pregnancy", "Diet", "Exercise", "Had multiple pregnancies"],
  [
    "Age",
    "History with Gestational Diabetes Mellitus",
    "Ethnicity",
    "Parity(Number of Chilren)",
    "Had multiple pregnancies"
  ]
];
const List<List<String>> Preeclampsia = [
  ["Weight"],
  [
    "Age",
    "Heigth",
    "Ethnicity",
    "Chronic hypertension",
    "Diabetes mellitus type 1 or 2",
    "History of preeclampsia"
  ]
];
const List<List<String>> PretermBirth = [
  ["Smoking", "Stress", "BMI pre pregnancy"],
  ["Age", "Ethnicity", "History of Diabetes", "Hypertension"]
];
const List<List<String>> Miscarriage = [
  ["Alcohol consuption", "Stress"],
  [
    "Age",
    "Ethnicity",
    "Nausea and vomiting in first trimester",
    "History of Miscarriage (also family history)",
    "Chronic hypertension"
  ]
];
const List<List<String>> StillBirth = [
  ["BMI", "Smoking"],
  ["Age", "Infection (Syphilis, Malaria)", "Ethnicity", "Chronic hypertnesion"]
];
const List<List<String>> PostpartumDepression = [
  ["Smoking", "Stress", "Diet"],
  ["Age", "Ethnicity"]
];
const List<List<String>> CesareanSection = [
  [],
  ["Age", "Height", "Gestational time(How far along in pregnancy"]
];
const List<List<String>> PlacentalAbruption = [
  [],
  [
    "Age",
    "Previous hypertension",
    "Previous preeclampsia",
    "Premature rupture of the membranes"
  ]
];
const List<List<String>> PlacentaPraevia = [
  ["Smoking during pregnancy", "Alcohol during pregnancy"],
  [
    "Age",
    "Had multiple pregnancies",
    "Previous caesarean section",
    "Previous Abortion"
  ]
];
const List<List<String>> Thrombosis = [
  ["Obesity", "Smoking", "Substance abuse"],
  [
    "Age",
    "Previous caesarean section",
    "Ethnicity",
    "Hypertension",
    "Heart disease",
    "History of thrombosis",
    "Diabetes"
  ]
];
const List<List<String>> HyperemesisGravidarum = [
  ["BMI pre pregnancy"],
  [
    "Hyperthyroid disorders",
    "Psychiatric illness",
    "Previous molar pregnancy",
    "Preexisting diabetes",
    "Asthma",
    "Had multiple pregnancies"
  ]
];
const List<List<String>> AntepartumHaemorrhage = [
  [""],
  [
    "Age",
    "Family history of G6PD",
    "Family History of Down Syndrome",
    "Previous caesarean section",
    "Previous Abortion"
  ]
];

get_affecting_factors(comp) {
  comp = comp.replaceAll(' ', '');
  comp = comp.replaceAll('-', '');

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
  return "Can't find any factors";
}
