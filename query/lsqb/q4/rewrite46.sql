## AggReduce Phase: 

# AggReduce138
# 1. aggView
create or replace view aggView4887281827524493143 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4178430450401726267 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4887281827524493143 where Message_hasCreator_Person.MessageId=aggView4887281827524493143.v1;

# AggReduce139
# 1. aggView
create or replace view aggView9139062745843472389 as select v1, SUM(annot) as annot from aggJoin4178430450401726267 group by v1;
# 2. aggJoin
create or replace view aggJoin2520490678213838418 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView9139062745843472389 where Person_likes_Message.MessageId=aggView9139062745843472389.v1;

# AggReduce140
# 1. aggView
create or replace view aggView5798685831537395865 as select v1, SUM(annot) as annot from aggJoin2520490678213838418 group by v1;
# 2. aggJoin
create or replace view aggJoin3904369698868342291 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5798685831537395865 where Comment_replyOf_Message.ParentMessageId=aggView5798685831537395865.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3904369698868342291;

# drop view aggView4887281827524493143, aggJoin4178430450401726267, aggView9139062745843472389, aggJoin2520490678213838418, aggView5798685831537395865, aggJoin3904369698868342291;
