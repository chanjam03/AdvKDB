// Feed tables
quote:([]time:`timespan$();sym:`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())
trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$())
OHLC:([]time:`timespan$(); sym:`symbol$();volume:`int$();maxPx:`float$();minPx:`float$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())

// Manual tables - To be updated by manual process
optTrades:([]time:`timespan$();sym:`symbol$();seq:`int$();expDate:`date$();strike:`float$();optionType:`symbol$();size:`int$();price:`float$();bbp:`float$();bap:`float$();ubp:`float$();uap:`float$();bp:`float$();ap:`float$();bs:`int$();as:`int$();ex:`symbol$())
