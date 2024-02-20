## AggReduce Phase: 

# AggReduce36
# 1. aggView
create or replace view aggView5884616005355888552 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2057356002049308139 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5884616005355888552 where Comment_replyOf_Message.ParentMessageId=aggView5884616005355888552.v1;

# AggReduce37
# 1. aggView
create or replace view aggView7008857995703760100 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin746372874570079169 as select v1, aggJoin2057356002049308139.annot * aggView7008857995703760100.annot as annot from aggJoin2057356002049308139 join aggView7008857995703760100 using(v1);

# AggReduce38
# 1. aggView
create or replace view aggView5968187739865247263 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1494839819223521771 as select aggJoin746372874570079169.annot * aggView5968187739865247263.annot as annot from aggJoin746372874570079169 join aggView5968187739865247263 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1494839819223521771;

# drop view aggView5884616005355888552, aggJoin2057356002049308139, aggView7008857995703760100, aggJoin746372874570079169, aggView5968187739865247263, aggJoin1494839819223521771;
