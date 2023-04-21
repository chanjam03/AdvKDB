// Feed tables
quote:([]time:`timestamp$();sym:`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())
trade:([]time:`timestamp$();sym:`symbol$();price:`float$();size:`int$())
OHLC:([]time:`timestamp$(); sym:`symbol$(); volume:`int$();maxPx:`float$();minPx:`float$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())

// Manual tables - To be updated by manual process
optTrades:([]TIMESTAMP:`timestamp$();UNDERLYING_SYMBOL:`symbol$();SEQ_NUM:`int$();EXP_DATE:`date$();STRIKE:`float$();OPTION_TYPE:`symbol$();SIZE:`int$();PRICE:`float$();BEST_BID_PX:`float$();BEST_ASK_PX:`float$();UNDERLYING_BID_PX:`float$();UNDERLYING_ASK_PX:`float$();BID_PX:`float$();ASK_PX:`float$();BID_SIZE:`int$();ASK_SIZE:`int$();EXCHANGE:`symbol$())

