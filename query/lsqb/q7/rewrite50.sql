## AggReduce Phase: 

# AggReduce150
# 1. aggView
create or replace view aggView2468985568782689948 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3262543208861489951 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2468985568782689948 where Message_hasCreator_Person.MessageId=aggView2468985568782689948.v1;

# AggReduce151
# 1. aggView
create or replace view aggView2245979812284913763 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4876422611742079479 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2245979812284913763 where Message_hasTag_Tag.MessageId=aggView2245979812284913763.v1;

# AggReduce152
# 1. aggView
create or replace view aggView2215399222453590205 as select v1, SUM(annot) as annot from aggJoin4876422611742079479 group by v1;
# 2. aggJoin
create or replace view aggJoin661419024856694553 as select aggJoin3262543208861489951.annot * aggView2215399222453590205.annot as annot from aggJoin3262543208861489951 join aggView2215399222453590205 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin661419024856694553;

# drop view aggView2468985568782689948, aggJoin3262543208861489951, aggView2245979812284913763, aggJoin4876422611742079479, aggView2215399222453590205, aggJoin661419024856694553;
