## AggReduce Phase: 

# AggReduce66
# 1. aggView
create or replace view aggView606237503907239456 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6626229265952257219 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView606237503907239456 where Person_likes_Message.MessageId=aggView606237503907239456.v1;

# AggReduce67
# 1. aggView
create or replace view aggView7534034636249545159 as select v1, SUM(annot) as annot from aggJoin6626229265952257219 group by v1;
# 2. aggJoin
create or replace view aggJoin1636241086432114969 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7534034636249545159 where Message_hasCreator_Person.MessageId=aggView7534034636249545159.v1;

# AggReduce68
# 1. aggView
create or replace view aggView2482726642807581896 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1820732625404402103 as select aggJoin1636241086432114969.annot * aggView2482726642807581896.annot as annot from aggJoin1636241086432114969 join aggView2482726642807581896 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1820732625404402103;

# drop view aggView606237503907239456, aggJoin6626229265952257219, aggView7534034636249545159, aggJoin1636241086432114969, aggView2482726642807581896, aggJoin1820732625404402103;
