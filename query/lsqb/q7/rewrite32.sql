## AggReduce Phase: 

# AggReduce96
# 1. aggView
create or replace view aggView4480766051409331930 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6333559317631147313 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4480766051409331930 where Message_hasTag_Tag.MessageId=aggView4480766051409331930.v1;

# AggReduce97
# 1. aggView
create or replace view aggView5332438638912904709 as select v1, SUM(annot) as annot from aggJoin6333559317631147313 group by v1;
# 2. aggJoin
create or replace view aggJoin4260769594586251761 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5332438638912904709 where Message_hasCreator_Person.MessageId=aggView5332438638912904709.v1;

# AggReduce98
# 1. aggView
create or replace view aggView3913264215240065188 as select v1, SUM(annot) as annot from aggJoin4260769594586251761 group by v1;
# 2. aggJoin
create or replace view aggJoin4048048442692221588 as select annot from Person_likes_Message as Person_likes_Message, aggView3913264215240065188 where Person_likes_Message.MessageId=aggView3913264215240065188.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4048048442692221588;

# drop view aggView4480766051409331930, aggJoin6333559317631147313, aggView5332438638912904709, aggJoin4260769594586251761, aggView3913264215240065188, aggJoin4048048442692221588;
