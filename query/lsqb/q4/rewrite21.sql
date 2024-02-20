## AggReduce Phase: 

# AggReduce63
# 1. aggView
create or replace view aggView7302324845501079141 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5721070301572931224 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7302324845501079141 where Person_likes_Message.MessageId=aggView7302324845501079141.v1;

# AggReduce64
# 1. aggView
create or replace view aggView5941667729864569956 as select v1, SUM(annot) as annot from aggJoin5721070301572931224 group by v1;
# 2. aggJoin
create or replace view aggJoin8062661339742605645 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5941667729864569956 where Message_hasCreator_Person.MessageId=aggView5941667729864569956.v1;

# AggReduce65
# 1. aggView
create or replace view aggView6333327552922234822 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8522135440684529831 as select aggJoin8062661339742605645.annot * aggView6333327552922234822.annot as annot from aggJoin8062661339742605645 join aggView6333327552922234822 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8522135440684529831;

# drop view aggView7302324845501079141, aggJoin5721070301572931224, aggView5941667729864569956, aggJoin8062661339742605645, aggView6333327552922234822, aggJoin8522135440684529831;
