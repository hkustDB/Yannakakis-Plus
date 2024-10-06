create or replace view aggView6836862070779618756 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin840865714475174188 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6836862070779618756 where Comment_replyOf_Message.CommentId=aggView6836862070779618756.v3;
create or replace view aggView2465956494877866071 as select v1, SUM(annot) as annot, v8 from aggJoin840865714475174188 group by v1,v8;
create or replace view aggJoin2964991900501804029 as select TagId as v2, v8, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2465956494877866071 where Message_hasTag_Tag.MessageId=aggView2465956494877866071.v1 and TagId<v8;
create or replace view aggView9059699779164522838 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin8533034990258751509 as select v2, v8, aggJoin2964991900501804029.annot * aggView9059699779164522838.annot as annot from aggJoin2964991900501804029 join aggView9059699779164522838 using(v2);
select SUM(annot) as v9 from aggJoin8533034990258751509;
