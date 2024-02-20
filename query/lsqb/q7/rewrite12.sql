## AggReduce Phase: 

# AggReduce36
# 1. aggView
create or replace view aggView6593982666598446696 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6337097525353046209 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6593982666598446696 where Message_hasCreator_Person.MessageId=aggView6593982666598446696.v1;

# AggReduce37
# 1. aggView
create or replace view aggView5711436649122469771 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5478244192746496448 as select v1, aggJoin6337097525353046209.annot * aggView5711436649122469771.annot as annot from aggJoin6337097525353046209 join aggView5711436649122469771 using(v1);

# AggReduce38
# 1. aggView
create or replace view aggView7734172683204778780 as select v1, SUM(annot) as annot from aggJoin5478244192746496448 group by v1;
# 2. aggJoin
create or replace view aggJoin4176911451872930215 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7734172683204778780 where Comment_replyOf_Message.ParentMessageId=aggView7734172683204778780.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4176911451872930215;

# drop view aggView6593982666598446696, aggJoin6337097525353046209, aggView5711436649122469771, aggJoin5478244192746496448, aggView7734172683204778780, aggJoin4176911451872930215;
