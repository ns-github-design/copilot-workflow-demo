const tripForm = document.getElementById("tripForm");
const itineraryEl = document.getElementById("itinerary");
const planTag = document.getElementById("planTag");
const demoTripBtn = document.getElementById("demoTripBtn");
const presenterModeBtn = document.getElementById("presenterModeBtn");
const closePresenterBtn = document.getElementById("closePresenterBtn");
const presenterPanel = document.getElementById("presenterPanel");
const daySelectEl = document.getElementById("daySelect");
const regenerateDayBtn = document.getElementById("regenerateDayBtn");

const hoursSavedEl = document.getElementById("hoursSaved");
const teamPulseEl = document.getElementById("teamPulse");
const budgetHealthEl = document.getElementById("budgetHealth");
const costCurrencyTagEl = document.getElementById("costCurrencyTag");
const perDayCostEl = document.getElementById("perDayCost");
const perStudentTotalEl = document.getElementById("perStudentTotal");
const groupTotalEl = document.getElementById("groupTotal");
const bufferAmountEl = document.getElementById("bufferAmount");

let currentModel = null;
let currentPlan = [];
let currentPerDayCost = 0;
let currentCurrency = "INR";

const vibeActivities = {
    adventure: [
        "Sunrise hill point hike",
        "Cycle rental city loop",
        "Kayak or water-activity block",
        "Squad challenge hunt",
        "Golden-hour viewpoint walk"
    ],
    culture: [
        "Old town and heritage walk",
        "Museum + student discount tour",
        "Local craft studio stop",
        "Architecture photo challenge",
        "Street music and culture lane"
    ],
    wellness: [
        "Sunrise stretch and cafe breakfast",
        "Nature trail reset session",
        "Budget healthy meal workshop",
        "Phone-free recharge block",
        "Sunset chill circle"
    ],
    food: [
        "Street food mapping tour",
        "Local market budget challenge",
        "Campus-style tasting trail",
        "Regional dessert hunt",
        "Late-night snack crawl"
    ]
};

const budgetNotes = {
    shoestring: "Use public transport, group stays, and free local experiences to keep costs low.",
    smart: "Balance comfort and cost with student offers and selective paid experiences.",
    comfort: "Choose better stays and easy transport while keeping activities curated and safe."
};

const indiaDestinationKeywords = [
    "goa",
    "jaipur",
    "manali",
    "rishikesh",
    "pondicherry",
    "mumbai",
    "delhi",
    "bengaluru",
    "bangalore",
    "hyderabad",
    "chennai",
    "kolkata",
    "kochi",
    "kerala",
    "india"
];

const destinationDayPlans = {
    goa: [
        "Arrive in North Goa, check-in, beach sunset, and local food crawl in Panaji",
        "Fort Aguada, Candolim beach time, and a water-sports block",
        "South Goa day trip with cafe hopping and evening market walk",
        "Local shopping, relaxed brunch, and return travel"
    ],
    jaipur: [
        "Arrive in Jaipur, check-in, evening at Hawa Mahal road and local snacks",
        "Amber Fort visit, Jal Mahal stop, and old city shopping trail",
        "City Palace, Jantar Mantar, and rooftop dinner with folk music",
        "Albert Hall area walk, souvenir shopping, and return travel"
    ],
    rishikesh: [
        "Arrive in Rishikesh, check-in, Ganga ghat evening, and cafe crawl",
        "River rafting block and sunset at Laxman Jhula",
        "Yoga session, Beatles Ashram visit, and riverside chill evening",
        "Local market shopping, brunch, and return travel"
    ],
    manali: [
        "Arrive in Manali, check-in, Mall Road walk, and local food spots",
        "Solang Valley adventure block and mountain viewpoint stops",
        "Old Manali cafe hopping and riverside photo trail",
        "Morning market run, relaxed brunch, and return travel"
    ],
    pondicherry: [
        "Arrive in Pondicherry, check-in, Promenade sunset walk, and French quarter cafes",
        "Auroville visit, beach chill block, and evening street food",
        "Heritage cycling trail and local boutique shopping",
        "Brunch by the coast, souvenir pickup, and return travel"
    ],
    mumbai: [
        "Arrive in Mumbai, check-in, Marine Drive sunset, and street food trail",
        "Gateway of India, Colaba causeway, and Bandra seaface evening",
        "Juhu beach block, local cafes, and sea-facing evening hangout",
        "Shopping run, brunch, and return travel"
    ]
};

const perStudentBudgetByCurrency = {
    INR: {
        shoestring: 3500,
        smart: 6500,
        comfort: 11000
    },
    USD: {
        shoestring: 45,
        smart: 90,
        comfort: 160
    }
};

function getDestinationKey(destination) {
    return String(destination || "").trim().toLowerCase();
}

function isIndiaDestination(destination) {
    const key = getDestinationKey(destination);
    return indiaDestinationKeywords.some((keyword) => key.includes(keyword));
}

function getCurrencyCode(destination) {
    return isIndiaDestination(destination) ? "INR" : "USD";
}

function formatAmount(currency, amount) {
    return `${currency} ${amount.toLocaleString("en-IN")}`;
}

function renderCostBreakdown({ currency, perDayCost, teamSize, days }) {
    const perStudentTotal = perDayCost * days;
    const groupTotal = perStudentTotal * teamSize;
    const bufferAmount = Math.round(groupTotal * 0.1);

    costCurrencyTagEl.textContent = currency;
    perDayCostEl.textContent = formatAmount(currency, perDayCost);
    perStudentTotalEl.textContent = formatAmount(currency, perStudentTotal);
    groupTotalEl.textContent = formatAmount(currency, groupTotal);
    bufferAmountEl.textContent = formatAmount(currency, bufferAmount);
}

function calculateMetrics(teamSize, days, budget) {
    const hourFactor = budget === "shoestring" ? 1.1 : budget === "comfort" ? 0.9 : 1;
    const hoursSaved = Math.round(teamSize * days * 0.6 * hourFactor);
    const teamPulse = Math.min(98, 58 + days * 6 + Math.round(teamSize / 5));
    const budgetHealth = budget === "shoestring" ? 92 : budget === "smart" ? 86 : 78;

    return { hoursSaved, teamPulse, budgetHealth };
}

function renderMetrics({ hoursSaved, teamPulse, budgetHealth }) {
    hoursSavedEl.textContent = `${hoursSaved}h`;
    teamPulseEl.textContent = `${teamPulse}%`;
    budgetHealthEl.textContent = `${budgetHealth}%`;
}

function createPlan({ destination, teamSize, days, budget, vibe }) {
    const activities = vibeActivities[vibe] || vibeActivities.culture;
    const plan = [];
    const destinationKey = getDestinationKey(destination);
    const currency = getCurrencyCode(destination);
    const perDayCost = perStudentBudgetByCurrency[currency][budget];
    const destinationTemplate = destinationDayPlans[destinationKey];

    for (let day = 1; day <= days; day += 1) {
        const fallbackFocus = activities[(day - 1) % activities.length];
        const focus = destinationTemplate?.[day - 1] || `${fallbackFocus} in ${destination}`;
        plan.push(
            `Day ${day}: ${focus}. Group size ${teamSize}. Estimated spend per student per day: ${formatAmount(currency, perDayCost)}. Copilot note: ${budgetNotes[budget]}`
        );
    }

    return { plan, currency, perDayCost };
}

function buildRemixLine(model, day, currency, perDayCost) {
    const activities = vibeActivities[model.vibe] || vibeActivities.culture;
    const activity = activities[Math.floor(Math.random() * activities.length)];
    const remixes = [
        "add one hidden local spot",
        "prioritize student discounts",
        "reduce travel hops for less fatigue",
        "include a photo and food stop",
        "keep one flexible hour for spontaneous plans"
    ];
    const remix = remixes[Math.floor(Math.random() * remixes.length)];

    return `Day ${day}: Copilot remix in ${model.destination}: ${activity}, then ${remix}. Group size ${model.teamSize}. Estimated spend per student per day: ${formatAmount(currency, perDayCost)}. Copilot note: ${budgetNotes[model.budget]}`;
}

function renderPlan(planItems, destination, vibe) {
    itineraryEl.innerHTML = "";

    planItems.forEach((item) => {
        const li = document.createElement("li");
        li.textContent = item;
        itineraryEl.appendChild(li);
    });

    planTag.textContent = `${destination} • ${vibe}`;
}

function renderDaySelector(days) {
    daySelectEl.innerHTML = "";
    for (let day = 1; day <= days; day += 1) {
        const option = document.createElement("option");
        option.value = String(day);
        option.textContent = `Day ${day}`;
        daySelectEl.appendChild(option);
    }
}

function runPlannerFromForm(form) {
    const formData = new FormData(form);

    const model = {
        destination: String(formData.get("destination") || "Your destination"),
        teamSize: Number(formData.get("teamSize") || 10),
        days: Number(formData.get("days") || 3),
        budget: String(formData.get("budget") || "smart"),
        vibe: String(formData.get("vibe") || "culture")
    };

    const { plan, currency, perDayCost } = createPlan(model);
    const metrics = calculateMetrics(model.teamSize, model.days, model.budget);

    currentModel = model;
    currentPlan = plan;
    currentPerDayCost = perDayCost;
    currentCurrency = currency;

    renderPlan(currentPlan, model.destination, model.vibe);
    renderDaySelector(model.days);
    renderMetrics(metrics);
    renderCostBreakdown({
        currency,
        perDayCost,
        teamSize: model.teamSize,
        days: model.days
    });
}

tripForm.addEventListener("submit", (event) => {
    event.preventDefault();
    runPlannerFromForm(tripForm);
});

regenerateDayBtn.addEventListener("click", () => {
    if (!currentModel || currentPlan.length === 0) {
        return;
    }

    const day = Number(daySelectEl.value || 1);
    const index = Math.max(0, Math.min(currentPlan.length - 1, day - 1));

    currentPlan[index] = buildRemixLine(currentModel, day, currentCurrency, currentPerDayCost);
    renderPlan(currentPlan, currentModel.destination, currentModel.vibe);
});

presenterModeBtn.addEventListener("click", () => {
    presenterPanel.classList.add("is-open");
    presenterPanel.setAttribute("aria-hidden", "false");
});

closePresenterBtn.addEventListener("click", () => {
    presenterPanel.classList.remove("is-open");
    presenterPanel.setAttribute("aria-hidden", "true");
});

demoTripBtn.addEventListener("click", () => {
    document.getElementById("destination").value = "Goa";
    document.getElementById("teamSize").value = "18";
    document.getElementById("days").value = "4";
    document.getElementById("budget").value = "smart";
    document.getElementById("vibe").value = "food";

    runPlannerFromForm(tripForm);
});
