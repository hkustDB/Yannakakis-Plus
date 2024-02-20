## AggReduce Phase: 

# AggReduce93
# 1. aggView
create or replace view aggView2481028263086361531 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin900345366202044922 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2481028263086361531 where Person_likes_Message.MessageId=aggView2481028263086361531.v1;

# AggReduce94
# 1. aggView
create or replace view aggView2937262080649774029 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin3588113239467189239 as select v1, aggJoin900345366202044922.annot * aggView2937262080649774029.annot as annot from aggJoin900345366202044922 join aggView2937262080649774029 using(v1);

# AggReduce95
# 1. aggView
create or replace view aggView5861731159395926861 as select v1, SUM(annot) as annot from aggJoin3588113239467189239 group by v1;
# 2. aggJoin
create or replace view aggJoin7552221018417004482 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5861731159395926861 where Message_hasCreator_Person.MessageId=aggView5861731159395926861.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin7552221018417004482;

# drop view aggView2481028263086361531, aggJoin900345366202044922, aggView2937262080649774029, aggJoin3588113239467189239, aggView5861731159395926861, aggJoin7552221018417004482;
