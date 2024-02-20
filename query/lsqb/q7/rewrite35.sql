## AggReduce Phase: 

# AggReduce105
# 1. aggView
create or replace view aggView4551780905397004333 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8909401276769268825 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4551780905397004333 where Person_likes_Message.MessageId=aggView4551780905397004333.v1;

# AggReduce106
# 1. aggView
create or replace view aggView125177740128687856 as select v1, SUM(annot) as annot from aggJoin8909401276769268825 group by v1;
# 2. aggJoin
create or replace view aggJoin7801250775997974649 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView125177740128687856 where Message_hasCreator_Person.MessageId=aggView125177740128687856.v1;

# AggReduce107
# 1. aggView
create or replace view aggView5005973759837757821 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6027136347707429583 as select aggJoin7801250775997974649.annot * aggView5005973759837757821.annot as annot from aggJoin7801250775997974649 join aggView5005973759837757821 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6027136347707429583;

# drop view aggView4551780905397004333, aggJoin8909401276769268825, aggView125177740128687856, aggJoin7801250775997974649, aggView5005973759837757821, aggJoin6027136347707429583;
