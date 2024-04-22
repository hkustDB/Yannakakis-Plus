create or replace view aggView6704239210183085091 as select name as v32, id as v31 from name as n;
create or replace view aggJoin7149249314060247030 as (
with aggView2232406907007165548 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2232406907007165548 where t.kind_id=aggView2232406907007165548.v26 and production_year>2000);
create or replace view aggView166072431369197840 as select v40, v41 from aggJoin7149249314060247030 group by v40,v41;
create or replace view aggJoin8739429433551597732 as (
with aggView7637861800372638941 as (select v40, MIN(v41) as v53 from aggView166072431369197840 group by v40)
select person_id as v31, movie_id as v40, person_role_id as v9, v53 from cast_info as ci, aggView7637861800372638941 where ci.movie_id=aggView7637861800372638941.v40);
create or replace view aggJoin4909244731091874455 as (
with aggView9169827655657815714 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v31, v40, v53 from aggJoin8739429433551597732 join aggView9169827655657815714 using(v9));
create or replace view aggJoin846235679044287506 as (
with aggView6095576535619134886 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView6095576535619134886 where cc.status_id=aggView6095576535619134886.v7);
create or replace view aggJoin1571833315733475146 as (
with aggView5568437107652664764 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView5568437107652664764 where mk.keyword_id=aggView5568437107652664764.v23);
create or replace view aggJoin7521629159838145835 as (
with aggView577807510384010806 as (select v40 from aggJoin1571833315733475146 group by v40)
select v40, v5 from aggJoin846235679044287506 join aggView577807510384010806 using(v40));
create or replace view aggJoin1117090214629421070 as (
with aggView3628567542048055425 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7521629159838145835 join aggView3628567542048055425 using(v5));
create or replace view aggJoin3679538813705339837 as (
with aggView5347526998865462479 as (select v40 from aggJoin1117090214629421070 group by v40)
select v31, v53 as v53 from aggJoin4909244731091874455 join aggView5347526998865462479 using(v40));
create or replace view aggJoin2933177813060679470 as (
with aggView6309550190007276023 as (select v31, MIN(v53) as v53 from aggJoin3679538813705339837 group by v31,v53)
select v32, v53 from aggView6704239210183085091 join aggView6309550190007276023 using(v31));
select MIN(v32) as v52,MIN(v53) as v53 from aggJoin2933177813060679470;
