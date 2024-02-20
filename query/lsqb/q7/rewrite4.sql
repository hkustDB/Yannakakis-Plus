## AggReduce Phase: 

# AggReduce12
# 1. aggView
create or replace view aggView914807492719622486 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3684805235120190013 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView914807492719622486 where Message_hasCreator_Person.MessageId=aggView914807492719622486.v1;

# AggReduce13
# 1. aggView
create or replace view aggView6498409809544483465 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7901931349504330400 as select v1, aggJoin3684805235120190013.annot * aggView6498409809544483465.annot as annot from aggJoin3684805235120190013 join aggView6498409809544483465 using(v1);

# AggReduce14
# 1. aggView
create or replace view aggView2811498239199163642 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4861028732789686750 as select aggJoin7901931349504330400.annot * aggView2811498239199163642.annot as annot from aggJoin7901931349504330400 join aggView2811498239199163642 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4861028732789686750;

# drop view aggView914807492719622486, aggJoin3684805235120190013, aggView6498409809544483465, aggJoin7901931349504330400, aggView2811498239199163642, aggJoin4861028732789686750;
