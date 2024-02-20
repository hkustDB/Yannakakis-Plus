## AggReduce Phase: 

# AggReduce144
# 1. aggView
create or replace view aggView4067234650536446045 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6643977890120465419 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4067234650536446045 where Message_hasTag_Tag.MessageId=aggView4067234650536446045.v1;

# AggReduce145
# 1. aggView
create or replace view aggView8236425336885826025 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4988318594643702108 as select v1, aggJoin6643977890120465419.annot * aggView8236425336885826025.annot as annot from aggJoin6643977890120465419 join aggView8236425336885826025 using(v1);

# AggReduce146
# 1. aggView
create or replace view aggView5499427589439286714 as select v1, SUM(annot) as annot from aggJoin4988318594643702108 group by v1;
# 2. aggJoin
create or replace view aggJoin6749846413519331559 as select annot from Person_likes_Message as Person_likes_Message, aggView5499427589439286714 where Person_likes_Message.MessageId=aggView5499427589439286714.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6749846413519331559;

# drop view aggView4067234650536446045, aggJoin6643977890120465419, aggView8236425336885826025, aggJoin4988318594643702108, aggView5499427589439286714, aggJoin6749846413519331559;
