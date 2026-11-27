---
name: smart-shopping-optimizer
description: Find the lowest reliable net cost for a retail purchase (electronics, cameras, computers, appliances and other big-ticket items, roughly $200 and up) by stacking the shopper's own credit cards, memberships, cashback and points portals, targeted card offers and live deals, all checked live, while keeping warranty and return protection. Use whenever the user wants to buy something like that, asks where or when to buy it, which card to pay with, whether there is a deal, or how to stack cashback and offers. Also use for Chinese requests such as「买 X 哪里最便宜」「这个刷哪张卡」「有没有 deal / 折扣可以叠」「现在买还是等黑五」「帮我算到手价」. Not for flights or hotels.
---

# Smart Shopping Optimizer

Produce a purchase plan the shopper can execute right now: which merchant, through which link or portal, paid with which card, at what verified net cost, and with what protection. This skill contains no personal data. Every shopper supplies their own profile (Step 0).

## Ground rules

- **Verify, never guess.** Prices, promo codes, portal rates, card offers, point valuations, bonus caps and card benefit terms all change. Count a discount in the guaranteed Net Cost only if you verified it live today. Tag everything else.
- **Reliability before marginal savings.** On big-ticket items, prefer authorized sellers, clean return policies and cards with Extended Warranty, Purchase Protection and Return Protection. Skip gray-market sellers and third-party marketplace listings unless the shopper asks for them.
- **Keep it simple.** Do not suggest gift-card resale sites or multi-step gift-card loops. Mention a simple, high-trust discounted gift card (for example one sold by a warehouse club) only when the saving is substantial, and warn that paying by gift card usually forfeits the card's warranty and purchase protection.
- **The shopper buys, not you.** You may add items to a cart, test promo codes and read the final total, but never place the order or submit payment. Ask before clicking "Add to card" on an offer or changing any account setting. Never type passwords or card numbers. If a page needs a sign-in, ask the shopper to sign in.
- **Speak the shopper's language.** Reply in the language they write in. Keep merchant, card and product names in their original form.
- **The shopper's own rules win.** If their profile has spending rules (valuation source, protection preferences, cards to avoid), follow them over the defaults here.

## Step 0: Load the shopper profile

Look for the profile in this order:

1. **The shopper's own instructions point to it.** Their CLAUDE.md, memory, account preferences or project knowledge may say where their cards and memberships live (a git repo, a file, a doc). Read the freshest copy: `git pull` a local clone, use the GitHub API or the right connector. Read the parts that cover cards, memberships and perks, and spending rules.
2. **They attached or pasted a profile** in this conversation.
3. **Neither.** Ask for the minimum listed in [references/profile-template.md](references/profile-template.md). Offer to fill in the template for them and save it wherever they want, so next time is instant. If they only want a rough answer, go ahead with what they gave and list your assumptions.

From the profile you need:
- Cards: earn rates, bonus caps, and which protections each card has.
- Memberships and their perks (warehouse club, Prime, retailer tiers).
- Portals and what they pay out in (cash or a points currency).
- Employee or affiliation discounts.
- Location, for sales tax.
- How they value points.
- Preferences: need-by date, risk tolerance, cards they don't want to use.

Note any of these the profile lacks. Don't invent them.

## Fast path

If the purchase is under about $200, or the question is only "which card", answer from the profile's category table plus a quick check of current rotating 5% categories and any obvious offer. Run the full workflow only if the shopper asks.

## Workflow

### 1. Pin down the product and timing
- Confirm the exact model, SKU and configuration. For a broad category, shortlist the top 1 or 2 models and say why.
- Ask or infer the need-by date. Use today's date to check for sale events in roughly the next 6 weeks: Black Friday and Cyber Monday, Prime Day and Prime Big Deal Days, back-to-school, holiday-weekend sales, and launches that push the previous generation down. Waiting is a legitimate recommendation.

### 2. Establish price baselines and history
- Check current prices at authorized merchants that carry the item: Amazon ("ships from and sold by Amazon"), Best Buy, Costco, B&H, Adorama, Walmart, Target, and the manufacturer's own store.
- Add every channel the profile unlocks: employee discount links, employee purchase portals (Perks at Work, manufacturer employee or partner stores), education pricing if eligible, and warehouse-club member pricing.
- Check price history with Keepa or CamelCamelCamel for Amazon, and with Slickdeals history or deal threads for other stores. Say whether today's price is at or near the all-time low, typical, or inflated.
- Price everything with sales tax for the shopper's location, plus shipping.

### 3. Rewards, portals, offers and deals
- **Cards.** For each candidate merchant, evaluate every card in the wallet, not just the usual favorites:
  - store and co-brand cards
  - category bonuses (online shopping, wholesale clubs, rotating 5%, choice categories)
  - the flat-rate fallback

  Note caps and how much room is left this quarter or year, if known. The merchant-tied programs in [references/retail-programs.md](references/retail-programs.md) are worth evaluating when the shopper has them.
- **Portals.** Use CashbackMonitor to compare portals for the merchant. Apply the payout currency from the profile (some portals pay points, not cash). Read the merchant's exclusions on the portal page, and note what breaks tracking.
- **Deals and data points.**
  - English: Slickdeals, Doctor of Credit, Reddit (for example r/buildapcsales).
  - Chinese: USCardForum (美卡论坛), USCreditCardGuide (美卡指南), Dealmoon (北美省钱快报).

  A forum data point stays unverified until you confirm it on the live page.
- **Point valuation.** Use the shopper's chosen source; if none, use The Points Guy's current monthly valuations, looked up today. Also compute a floor value: the profile's cash-out rate, or 1¢ per point. When the result hinges on valuation, use Frequent Miler's Reasonable Redemption Values as a tiebreaker.

### 4. Check protections
- For the top card candidates, read the issuer's current benefit terms instead of relying on memory:
  - **Extended Warranty:** maximum original warranty length that qualifies, how much it extends, per-claim cap.
  - **Purchase Protection:** days covered, cap.
  - **Return Protection:** days, per-item cap, and whether the card still offers it.
- Merchant protections count too:
  - warehouse-club return windows and any free warranty extension
  - retailer membership return windows
  - holiday return extensions
- Weigh protection by product: high-failure or high-value electronics deserve more weight than low-risk items.
- Paying partly with a gift card, store credit, points or buy-now-pay-later can reduce or void card coverage. Say so when a plan does that.

### 5. Verify in the browser
Use the browser where the shopper is already signed in (for example Claude in Chrome). Fall back to a built-in browser for public pages. Verify:
- Targeted card offers. On issuers that list offers per card, check every card in the wallet.
- Merchant and targeted promotions.
- The live portal rate and its exclusions.
- Member and employee pricing while signed in.
- The cart total with tax and shipping, including whether a promo code applies.

Stop before submitting the order. If a check cannot be completed (not signed in, the shopper declines, the page blocks automation), mark that item unverified and leave it out of the guaranteed Net Cost.

### 6. Calculate Net Cost
For the top 2 to 4 realistic paths:

```
Net Cost = verified checkout total (tax + shipping)
         - card rewards       (rate × eligible amount × point value)
         - portal reward      (rate × eligible amount × point value)
         - verified targeted offers
         - verified membership rewards (for example a warehouse club's annual reward)
```

- Card rewards usually earn on the amount including tax. A card that rebates sales tax changes that base, so compute it on the real charge.
- Respect caps. Treat a membership fee as sunk unless the shopper would join just for this purchase.
- Show points-based paths at both the chosen valuation and the floor value.
- Name the trade-offs, especially:
  - sales-tax savings versus warranty and return protection
  - a portal versus an employee link that breaks portal tracking
  - buying now versus waiting for a sale

### 7. After the purchase
- Note each price-adjustment option and its deadline: warehouse-club price adjustment windows, retailer price-match within the return window, and returning and rebuying where the policy allows it. Offer a reminder or scheduled check before the return window closes, if the environment supports one.
- If the profile lives somewhere writable and the shopper agrees, record what they bought: product, merchant, date, price, card, return deadline, manufacturer warranty end, and extended warranty end. Remind them to keep the receipt and card statement; warranty claims need both.

## Output format

1. **Bottom line.** Buy now or wait (and until when). Then merchant, link or portal, card, and Net Cost (at the chosen valuation and the floor), plus one line on why it wins, including protection.
2. **Comparison table** of 2 to 4 paths:

   | Path (merchant · link/portal · card) | Checkout total | Rewards and offers | Net Cost | Protection |
   |---|---|---|---|---|

3. **Status tags** on every discount, rate and offer: `[Verified Live]` (checked today), `[Forum DP - Unverified]` (recent community report, not counted), `[Assumption]` (from the profile or a stated assumption).
4. **Execution checklist.** Numbered steps with a link to every page and deal thread, for example: activate the offer, open the portal, open the merchant, check out with a named card. The last step is "you place the order". Follow it with any post-purchase reminders from Step 7.

## Gotchas

- **Incompatible stacks.** Employee and corporate links, and coupon codes not issued by the portal, often break portal tracking. Don't count both without proof.
- **Portal exclusions.** Apple products, game consoles, gift cards, some cameras and GPUs, and open-box items are often excluded. Read the fine print on the portal page.
- **Marketplace sellers.** On Amazon, Walmart and similar sites, confirm who ships and sells the item. Third-party listings change warranty and return terms.
- **Rotating and choice categories** may need activation or a category change before the purchase, and they have caps.
- **Targeted offers** usually must be enrolled before purchase. Many exclude third-party sellers, gift cards, or certain payment methods. Read the terms.
- **Price errors** are often cancelled. Mention them, but never build the plan on one.
- **Prices vary** by ZIP code, membership and sign-in state. Check while signed in when it matters.
