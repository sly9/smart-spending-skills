---
name: hotel-optimizer
description: Find the best way to book a hotel stay by comparing, for each candidate property, the brand's own member rate, points and free-night certificates, premium-card hotel programs (Amex Fine Hotels + Resorts and The Hotel Collection, Chase The Edit and similar), discount rates, and online travel agencies with cashback portals, using the traveler's own cards, points balances, elite status and certificates, all checked live, while keeping cancellation flexibility in view. Use whenever the user wants to book or price a hotel, asks whether to pay cash or points, which card to put a stay on, how to use a free-night certificate or hotel credit, whether FHR or The Edit is worth it, or whether to rebook after a price drop. Also use for Chinese requests such as「订酒店怎么最划算」「这晚用积分还是付现金」「房券怎么用」「FHR 值不值」「酒店刷哪张卡」「这家酒店降价了要不要重订」. Not for flights, vacation rentals or timeshares.
---

# Hotel Optimizer

Produce a booking plan the traveler can execute right now: which property, booked through which channel, at which rate, paid with cash, points or a certificate on which card, at what verified net cost, with which benefits and which cancellation terms. This skill contains no personal data. Every traveler supplies their own profile (Step 0).

## Ground rules

- **Verify, never guess.** Room rates, award prices, transfer ratios and bonuses, card hotel credits, program benefits, point valuations and promotions all change. Count something in the guaranteed Net Cost only if you verified it live today. Tag everything else.
- **Compare all-in prices.** Always compare totals for the whole stay with taxes, resort or destination fees and the parking the traveler needs. A nightly rate before fees is not a price.
- **Flexibility is the protection.** Prefer refundable rates unless a prepaid rate saves enough to justify the risk, and say what the risk is. A refundable booking can be rebooked if the price drops.
- **The traveler books, not you.** You may search rates, open booking pages and read the final total, but never complete a booking, pay, or redeem points or a certificate. **Never transfer points** between programs: transfers are usually instant and irreversible. Tell the traveler to transfer only after they have confirmed that the award room is available, and to transfer exactly what the booking needs. Ask before enrolling a promotion or offer, or changing any account setting. Never type passwords or card numbers.
- **Hand off what only the traveler can do.** If a page needs a sign-in or any other step only the traveler can do, open it in a tab, leave the tab there and tell them what to do in it (see Step 5).
- **Speak the traveler's language.** Reply in the language they write in. Keep hotel, brand, program and card names in their original form.
- **The traveler's own rules win.** If their profile has rules (valuation source, preferred brands, cards to avoid), follow them over the defaults here.

## Step 0: Load the traveler profile

Look for the profile in this order:

1. **The traveler's own instructions point to it.** Their CLAUDE.md, memory, account preferences or project knowledge may say where their cards, memberships and rules live (a git repo, a file, a doc). Read the freshest copy: `git pull` a local clone, use the GitHub API or the right connector.
2. **They attached or pasted a profile** in this conversation.
3. **Neither.** Ask for the minimum listed in [references/profile-template.md](references/profile-template.md). Offer to fill in the template for them and save it wherever they want. If they only want a rough answer, go ahead with what they gave and list your assumptions.

From the profile you need:
- Hotel programs, member numbers (last digits are enough) and elite status, and where each status comes from (earned, card-granted).
- Points balances, both hotel and transferable currencies. Balances in a profile go stale, so check them live in Step 5.
- Free-night certificates: program, category or points cap, expiry date, and whether they can be topped up with points.
- Cards: hotel earn rates, co-brand cards, hotel credits and how much is left in the current period, and travel insurance (trip cancellation and interruption).
- Discount eligibility: AAA, warehouse club, employer or corporate rates, government, military, senior.
- How they value points.
- Preferences: brands they like or avoid, room and bed needs, whether breakfast matters to them, risk tolerance for prepaid rates.

Note anything the profile lacks. Don't invent it.

## Fast path

If the question is only "which card for this stay", or the stay is one or two nights at a modest rate, answer from the profile: the co-brand card for that brand, else the best general hotel or travel card, plus a quick check for an obvious card offer or brand promotion. Run the full workflow only if the traveler asks, or if points, a certificate or a premium-card credit could plausibly change the answer.

## Workflow

### 1. Pin down the stay
- Destination, check-in and check-out dates, flexibility (a night earlier or later, or weekday versus weekend, can change award prices and fifth-night-free eligibility), number of guests and rooms, beds, and the purpose of the trip.
- If they haven't picked a hotel, shortlist 2 to 4 properties that fit: at least one from each brand where they have status or points, plus an independent hotel if one stands out. Say why each is on the list.
- If they have already booked, the job is to decide whether to rebook: get the existing rate, its cancellation deadline and how it was paid.

### 2. Price every channel for each property
For each property, check the channels that apply; see [references/hotel-programs.md](references/hotel-programs.md) for how each program works.

- **Brand direct, cash.** The member rate, and any discount rate the traveler qualifies for (AAA, corporate, senior, government), plus packages (breakfast, parking, credit). Note whether each rate is refundable and until when.
- **Brand direct, points.** The award price for the exact dates, cash-plus-points if offered, fifth or fourth night free rules, and whether resort fees are charged on award stays at that brand.
- **Certificates.** Any certificate the traveler holds that fits this property and these dates, including a points top-up. Use the certificate that expires soonest first, if it fits. Accounts can still list a certificate after its expiry date; flag those instead of planning on them.
- **Transferable points.** If the traveler is short on hotel points, which transferable currencies reach this brand, at what ratio, and whether there is a transfer bonus today. Read the ratio on the traveler's own transfer page: ratios can differ by card or by cardholder. TPG's monthly valuations page also lists the current transfer bonuses.
- **Can they afford it?** Before building a points path, add up what the traveler can actually reach: the hotel balance plus each transferable balance at their own ratio. If that falls short of the full award, drop the full-award path and check points-plus-cash instead.
- **Premium-card hotel programs.** Whether the property is in Amex Fine Hotels + Resorts or The Hotel Collection, Chase The Edit, Capital One Premier Collection or a similar program for a card the traveler has. Get that program's rate for the same dates, its benefits, whether it is prepaid, and whether a card hotel credit applies.
- **Online travel agencies and card travel portals.** A price check on Google Hotels to see the market, and on the agency or card portal only if it is clearly cheaper. These bookings usually forfeit elite benefits, points and elite night credit, and are harder to change. Check a cashback portal (CashbackMonitor) for the agency, if you use one.
- **Warehouse-club travel** (for example Costco Travel) for resort or package stays, which sometimes includes a club gift card.

Use the same room type across channels, or say when you can't.

### 3. Rewards, offers and promotions
- **Cards.** For each realistic channel, find the best card: the brand's co-brand card for a direct booking; a premium card's elevated rate for its own travel portal or hotel program; the general travel or flat-rate card otherwise. Check whether the card codes the charge as hotel or travel. A prepaid booking charges now; a pay-at-hotel booking charges at checkout, which matters for card credits by period and for sign-up bonus deadlines.
- **Points earned on cash stays.** Base points, elite bonus, and the co-brand card's earn, at the traveler's valuation.
- **Brand promotions.** Current registration promotions (bonus points, extra nights toward status). Most require registering before the stay.
- **Targeted card offers.** Amex Offers, Chase Offers and similar for that brand or property. Most must be enrolled before booking, and many exclude bookings through third parties.
- **Deals and data points.**
  - English: Doctor of Credit, Frequent Miler, One Mile at a Time, The Points Guy, View from the Wing, Reddit (for example r/awardtravel, r/churning).
  - Chinese: USCardForum (美卡论坛), USCreditCardGuide (美卡指南), Dealmoon (北美省钱快报) for travel sales.

  A forum data point stays unverified until you confirm it on the live page.
- **Point valuation.** Use the traveler's chosen source; if none, use The Points Guy's current monthly valuations at `thepointsguy.com/loyalty-programs/monthly-valuations/`, looked up today. If you can only find an older month, say which month you used. When the decision hinges on valuation, use Frequent Miler's Reasonable Redemption Values as a tiebreaker.

### 4. Value the benefits and the flexibility
- **Benefits.** Count only benefits the traveler would actually use, and value them below their face value: breakfast at what the traveler would otherwise spend, a property credit at what they would spend at the property anyway. A space-available upgrade, early check-in or late checkout that isn't guaranteed adds nothing to Net Cost; list it as a perk.
- **Elite benefits** apply only to direct bookings and to some premium-card programs. Note when a channel loses them, and when a channel still credits points and elite nights.
- **Cancellation.** For each path, say whether it is refundable, the deadline (in the hotel's local time) and the penalty. A prepaid saving has to be weighed against the chance plans change.
- **Travel insurance.** If the traveler is paying a prepaid or non-refundable rate, check whether the card they pay with has trip cancellation or interruption coverage, and read the current terms. Coverage usually applies only when the trip is paid with that card or its points.
- **Status.** If the stay would push the traveler to a new status tier, or a promotion counts extra nights, mention it in one line. Don't optimize for status unless they ask.

### 5. Verify in the browser
Use the browser where the traveler is already signed in (for example Claude in Chrome). Fall back to a built-in browser for public pages.

First, check which of the needed accounts are signed in: each hotel program (member rates, award prices, points balances and certificates show only when signed in), the card issuers (hotel programs, credits, offers, transferable points) and any portal. Do this early: asking only at the end leaves the member rates and offers unverified.

**Hand off to the traveler.** Some steps only the traveler can do: signing in, a 2FA code, a CAPTCHA or bot check, a page that blocks automation, a consent prompt, enrolling an offer or promotion you weren't told to enroll. For each one:
- Open the exact page in its own tab (the program's sign-in page, the card's hotel program search, the offers page of the right card) and leave it there. Don't close that tab, navigate it elsewhere or reuse it for other checks.
- Open all such tabs first, then tell the traveler once, in one list: for each tab, the site, what to do there, and what you'll read there afterward. They can reply "done" or "skip" for each.
- Meanwhile, keep doing the public checks in other tabs.
- When they say done, go back to those tabs (reload if needed) and carry on. If a page still blocks automation, ask them to read you the number off it. If they skip, mark that item unverified.
- If nobody answers (an unattended run), still leave the tabs open, finish the rest, and list the tabs under "Waiting for you" in the answer.
- Don't close the tabs you handed off when you finish. The traveler may still need them to book.

Verify:
- The final total for each top path, on the last page before payment: taxes, fees, deposit, cancellation terms.
- The award price and availability for the exact dates and room type.
- Points balances and certificates in the account, with their expiry dates.
- Premium-card program rates and benefits, and how much of each card credit is left.
- Targeted offers and promotion registration status.

Stop before booking. If a check still cannot be completed after the hand-off, mark that item unverified and leave it out of the guaranteed Net Cost.

**Working the pages efficiently.**
- Hotel pages carry long review lists. Don't dump the whole page text; read only the rates section, or one rate's details and its cancellation policy.
- Set dates on the brand's own site. Aggregators (for example Google Hotels) may ignore dates passed in the URL and show prices for other dates.
- Open each rate to read its cancellation policy. The cheapest "member" rate is often prepaid and non-refundable, and holiday periods can have much longer cancellation windows than usual.
- A review or express-checkout page may switch to a different rate than the one you picked. Confirm the rate name and the total on that page. Never press the final book or pay button.
- Local taxes collected at the hotel (for example a per-person accommodation tax) may not be in the online total. Read the tax notes.
- If you can't operate a search form (a date picker that won't take input, a page that won't load), fill in what you can, leave the tab open and add it to the hand-off list.

### 6. Calculate Net Cost
For the top 2 to 4 realistic paths:

```
Cash path:
Net Cost = all-in total (taxes + fees + parking)
         - card credits that this booking actually uses
         - points earned  (base + elite bonus + card earn, × point value)
         - portal reward  (if any)
         - verified targeted offers
         - value of benefits the traveler will use

Points or certificate path:
Net Cost = cash still due (resort fees, taxes if any, parking, top-up points × value)
         + points redeemed × point value
         - value of benefits the traveler will use
Cents per point = (cash path all-in total - cash still due) / points redeemed
```

- Show points paths at the chosen valuation and say the cents per point the redemption gets. A redemption below the valuation is usually better paid in cash, unless the traveler wants to spend those points.
- A certificate's value is the cash rate it replaces, minus any top-up. A certificate about to expire unused is worth nothing, so it should win whenever it fits.
- A card credit counts only if the traveler would otherwise not use it this period. Say which period it comes from. A credit that expires before the traveler would otherwise use it counts at full value; say the deadline, and that a prepaid booking usually counts by its charge date, not the stay date.
- Points earned on a cash stay usually exclude taxes and fees; the card earns on the whole charge.
- Name the trade-offs, especially:
  - prepaid and cheaper versus refundable
  - a premium-card program's benefits versus the brand's direct rate and elite benefits
  - spending points now versus saving them
  - a cheaper agency rate versus losing status benefits and points

### 7. After booking
- Note each cancellation deadline. For refundable bookings, offer a reminder or scheduled check to re-price the stay before that deadline, if the environment supports one, and tell the traveler to keep the original booking until the new one is confirmed.
- Award prices can drop too; some programs let the traveler rebook or get points back. Say so when it applies.
- If the profile lives somewhere writable and the traveler agrees, record the booking: property, dates, channel, rate, confirmation number's last digits, cancellation deadline, card, and any certificate or credit used (mark the certificate as used).

## Output format

1. **Bottom line.** Property, channel, rate, how to pay (cash on which card, points or a certificate), Net Cost, cancellation terms, plus one line on why it wins.
2. **Comparison table** of 2 to 4 paths:

   | Path (property · channel · rate · payment) | All-in total | Points used / earned | Benefits you'll use | Net Cost | Cancellation |
   |---|---|---|---|---|---|

3. **Status tags** on every rate, price, credit and offer: `[Verified Live]` (checked today), `[Forum DP - Unverified]` (recent community report, not counted), `[Assumption]` (from the profile or a stated assumption). You may translate the tags into the traveler's language, but use the same three throughout one answer.
4. **Execution checklist.** Numbered steps with a link to every page: register the promotion, enroll the offer, transfer points (only after confirming availability, with the exact amount), open the booking page, pay with a named card. The last step is "you book it". Follow it with the cancellation deadline and any reminder from Step 7.
5. **Waiting for you** (only if any hand-off is still open): each tab you left open, what to do in it, and what it would add to the plan once done.

## Gotchas

- **Resort and destination fees** are often hidden until the last page and may apply to award stays. Read the last page.
- **Room type mismatch.** Award and program rates may be for a different room than the cash rate you compare against.
- **Prepaid rates** are often non-refundable. Premium-card hotel credits often require prepaid bookings through the card's own travel site.
- **Card travel portals and agencies** are third-party bookings: changes go through the agency, and elite benefits and points usually don't apply. Premium-card hotel programs are an exception for some brands; check.
- **Minimum stays.** Some programs and credits need two nights or more.
- **Discount rates need proof.** AAA, corporate, government and senior rates may be checked at check-in. Use only rates the traveler qualifies for.
- **Certificate limits.** Certificates have a category or points cap, may exclude some properties or room types, and expire. Some programs allow a points top-up; some don't.
- **Transfers** can take time for some partners, and award space can disappear in between. Check before telling the traveler to transfer, and warn when a partner is slow.
- **Dates are in the hotel's local time** for check-in and cancellation deadlines.
