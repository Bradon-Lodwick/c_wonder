"""
Writes csv files to be imported into the database with random dummy entries
"""
from random import choice, randint

elements = 1000
bounds = (1, 30)
adjectives = ["3D", "Flying", "Small", "Cloud", "Blue", "Green", "Satisfying", "Enraged", "Dangerous", "Miserable",
              "Screeching", "Brash", "Ethical", "Lackadaisical", "Surprised", "Courteous", "Lavish", "Unimportant",
              "Cut", "Another", "Offbeat", "Stupid", "Imaginative", "Incredible", "Jumbo", "Guarded", "Desperate",
              "Golden", "Federal", "Jovial", "Lanky", "Chivalrous", "Breezy", "Bland", "Dreary", "Nonchalant",
              "Kooky", "Wasteful", "Virtual", "Uninterested", "Popular", "Anxious", "Literate", "Womanly", "Agonizing",
              "Premium", "Nice", "Shaky", "Brainy", "Triangular", "Outlying", "Giant", "Lovely", "Whirlwind", "Crabby",
              "Foreign", "Hearty", "Sweltering", "Forgetful", "Divergent", "Spiky", "Exhausted", "Racial", "Cool",
              "True", "Prestigious", "Playful", "Therapeutic", "Physical", "Brash", "Nasty", "Haunting",
              "Incompatible", "Exemplary", "Raw", "Charming", "Improbable", "Tested", "Supreme", "Accurate", "Demonic",
              "Torn", "Capable", "Jobless", "Lame", "Klutzy", "Secondary", "Imperfect", "Melancholy", "Incandescent",
              "Former", "Equable", "Petty", "Ripe", "Extra-Large", "Ordinary", "Appetizing", "Asleep", "Devoted",
              "Proud", "Innocent", "Clammy", "Straight", "Great", "Natural", "Picayune", "Ill-Informed", "Noteworthy",
              "Lumpy", "Obnoxious", "Deficient", "Longing", "Parallel", "Suburban", "Popular", "Cultivated", "Elegant",
              "Befitting", "Diminutive", "Wild", "Reckless", "Careful", "Courageous", "Giving", "Knowing",
              "Mysterious", "Absurd", "Aquatic", "Steadfast", "Gullible", "Amazing", "Tremendous", "Growing", "Thick",
              "Snoopy", "Immense", "Well-Made", "Failing", "Dimpled", "Incomparable", "Growling", "Ubiquitous",
              "Shaggy", "Untidy"]
nouns =     ["Hospital", "Memory", "Still", "Competition", "File", "Cup", "Philosophy", "Perspective", "Possession",
             "Letter", "Recover", "Wine", "Green", "Offer", "Loan", "Cut", "List", "National", "Sink", "Security",
             "Employ", "Pressure", "Eat", "Brother", "Fact", "Bottle", "Panic", "Tea", "Go",
             "Valuable", "Reference", "Physical", "Personal", "Girlfriend", "Air", "Body", "Formal", "Atmosphere",
             "Bar", "Beach", "Sick", "Orange", "Internet", "Magazine", "Objective", "Apartment", "Hold", "Computer",
             "Rich", "Analyst", "Revolution", "Dependent", "Pizza", "Material", "Milk", "Nose", "Intention", "Parent",
             "Part", "Scratch", "Hurry", "Injury", "Spirit", "Representative", "Burn", "Quote", "Resolve", "Nation",
             "Till", "Stress", "Instruction", "Break", "Conflict", "Reach", "Tap", "Other", "Row", "Research",
             "Assist", "Post", "Answer", "Excuse", "Dish", "Employee", "Beer", "Effect", "Housing", "Solid", "Classic",
             "Natural", "Road", "Particular", "Opinion", "Ticket", "Strain", "Block", "Return", "Bet"]

full_items = []

while (len(full_items) < elements):
    item = " ".join((choice(adjectives), choice(nouns)))
    if not item in full_items:
        full_items.append(item)

with open("inventory.csv", "w") as f:
    for index, item in enumerate(full_items):
        data = (index, item, randint(*bounds))
        f.write(",".join([str(d) for d in data])+"\n")


