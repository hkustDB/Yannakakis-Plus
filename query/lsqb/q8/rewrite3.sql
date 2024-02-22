create or replace view aggView3497923359771240635 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin4161365741532544323 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3497923359771240635 where Comment_replyOf_Message.CommentId=aggView3497923359771240635.v3;
create or replace view aggView6623964718109330844 as select v1, SUM(annot) as annot, v8 from aggJoin4161365741532544323 group by v1,v8;
create or replace view aggJoin935004352834727010 as select TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6623964718109330844 where Message_hasTag_Tag.MessageId=aggView6623964718109330844.v1 and TagId<v8;
create or replace view aggView4886639720666335452 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin6898357150642705698 as select aggJoin935004352834727010.annot * aggView4886639720666335452.annot as annot from aggJoin935004352834727010 join aggView4886639720666335452 using(v2);
select SUM(annot) as v9 from aggJoin6898357150642705698;
