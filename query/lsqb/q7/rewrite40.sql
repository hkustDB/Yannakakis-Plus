## AggReduce Phase: 

# AggReduce120
# 1. aggView
create or replace view aggView3450707918539228680 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3211852414410371788 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3450707918539228680 where Message_hasCreator_Person.MessageId=aggView3450707918539228680.v1;

# AggReduce121
# 1. aggView
create or replace view aggView1389774809802137712 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4151993666470881900 as select v1, aggJoin3211852414410371788.annot * aggView1389774809802137712.annot as annot from aggJoin3211852414410371788 join aggView1389774809802137712 using(v1);

# AggReduce122
# 1. aggView
create or replace view aggView1649421953141415240 as select v1, SUM(annot) as annot from aggJoin4151993666470881900 group by v1;
# 2. aggJoin
create or replace view aggJoin2357239543683168164 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1649421953141415240 where Message_hasTag_Tag.MessageId=aggView1649421953141415240.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2357239543683168164;

# drop view aggView3450707918539228680, aggJoin3211852414410371788, aggView1389774809802137712, aggJoin4151993666470881900, aggView1649421953141415240, aggJoin2357239543683168164;
