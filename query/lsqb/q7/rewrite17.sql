## AggReduce Phase: 

# AggReduce51
# 1. aggView
create or replace view aggView5620259516496490908 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3567451905403734062 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5620259516496490908 where Message_hasCreator_Person.MessageId=aggView5620259516496490908.v1;

# AggReduce52
# 1. aggView
create or replace view aggView3167215904782443903 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5256483887878287011 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3167215904782443903 where Comment_replyOf_Message.ParentMessageId=aggView3167215904782443903.v1;

# AggReduce53
# 1. aggView
create or replace view aggView6267179610934066179 as select v1, SUM(annot) as annot from aggJoin5256483887878287011 group by v1;
# 2. aggJoin
create or replace view aggJoin2121167421313630572 as select aggJoin3567451905403734062.annot * aggView6267179610934066179.annot as annot from aggJoin3567451905403734062 join aggView6267179610934066179 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2121167421313630572;

# drop view aggView5620259516496490908, aggJoin3567451905403734062, aggView3167215904782443903, aggJoin5256483887878287011, aggView6267179610934066179, aggJoin2121167421313630572;
