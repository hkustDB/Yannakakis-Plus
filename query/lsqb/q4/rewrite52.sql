create or replace view aggView1486798216370437518 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin6748535170328798179 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1486798216370437518 where Message_hasCreator_Person.MessageId=aggView1486798216370437518.v1;
create or replace view aggView2799423578583317338 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6064969507452933030 as select v1, aggJoin6748535170328798179.annot * aggView2799423578583317338.annot as annot from aggJoin6748535170328798179 join aggView2799423578583317338 using(v1);
create or replace view aggView471534312085028459 as select v1, SUM(annot) as annot from aggJoin6064969507452933030 group by v1;
create or replace view aggJoin3062764382566341186 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView471534312085028459 where Comment_replyOf_Message.ParentMessageId=aggView471534312085028459.v1;
select SUM(annot) as v9 from aggJoin3062764382566341186;
