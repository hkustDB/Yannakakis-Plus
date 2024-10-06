create or replace view semiUp6438887448897284361 as select CommentId as v3, ParentMessageId as v1 from Comment_replyOf_Message AS Comment_replyOf_Message where (CommentId) in (select (CommentId) from Comment_hasTag_Tag AS cht);
create or replace view semiUp6887081722379109094 as select MessageId as v1, TagId as M_TagId from Message_hasTag_Tag AS Message_hasTag_Tag where (MessageId) in (select (v1) from semiUp6438887448897284361);
create or replace view semiDown300551410123938824 as select v3, v1 from semiUp6438887448897284361 where (v1) in (select (v1) from semiUp6887081722379109094);
create or replace view semiDown2876504595255914123 as select CommentId as v3, TagId as cht_TagId from Comment_hasTag_Tag AS cht where (CommentId) in (select (v3) from semiDown300551410123938824);
create or replace view aggView532887711989860493 as select v3, cht_TagId, COUNT(*) as annot from semiDown2876504595255914123 group by v3, cht_TagId;
create or replace view aggJoin8785041069522064121 as select v1, cht_TagId, annot from semiDown300551410123938824 join aggView532887711989860493 using(v3);
create or replace view aggView397277630085780347 as select v1, cht_TagId, SUM(annot) as annot from aggJoin8785041069522064121 group by v1, cht_TagId;
create or replace view aggJoin417308225236302084 as select annot from semiUp6887081722379109094 join aggView397277630085780347 using(v1) where M_TagId < cht_TagId;
select SUM(annot) as v7 from aggJoin417308225236302084;
