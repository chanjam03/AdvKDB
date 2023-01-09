/ Feed tables
quote:([]time:`timespan$();sym:`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())
trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$())
OHLC:([]time:`timespan$(); sym:`symbol$(); volume:`int$();maxPx:`float$();minPx:`float$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())

/ Manual tables
/ optTrades:([]TIMESTAMP:`date$();UNDERLYING_SYMBOL:`symbol$();SEQ_NUM:`int$();EXP_DATE:`date$();STRIKE:`float$();OPTION_TYPE:`symbol$();SIZE:`int$();PRICE:`float$();BEST_BID_PX:`float$();BEST_ASK_PX:`float$();UNDERLYING_BID_PX:`float$();UNDERLYING_ASK_PX:`float$();BID_PX:`int$();ASK_PX:`int$();EXCHANGE:`symbol$())