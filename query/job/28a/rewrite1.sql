create or replace view aggView6985915702130815654 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4645737328550041982 as (
with aggView1126091922943089980 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1126091922943089980 where mi.info_type_id=aggView1126091922943089980.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8026667484109821152 as (
with aggView7336684318393724791 as (select v45 from aggJoin4645737328550041982 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7 from complete_cast as cc, aggView7336684318393724791 where cc.movie_id=aggView7336684318393724791.v45);
create or replace view aggJoin7907217610337372603 as (
with aggView2844265911741284703 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select v45, v5 from aggJoin8026667484109821152 join aggView2844265911741284703 using(v7));
create or replace view aggJoin2264832713894179506 as (
with aggView8883976202727336949 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin7907217610337372603 join aggView8883976202727336949 using(v5));
create or replace view aggJoin4823482832909960535 as (
with aggView7131254975790393540 as (select v45 from aggJoin2264832713894179506 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView7131254975790393540 where mi_idx.movie_id=aggView7131254975790393540.v45 and info<'8.5');
create or replace view aggJoin6417690024204271573 as (
with aggView4663812896141502107 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4663812896141502107 where t.kind_id=aggView4663812896141502107.v25 and production_year>2000);
create or replace view aggView9059213845830481616 as select v45, v46 from aggJoin6417690024204271573 group by v45,v46;
create or replace view aggJoin8226513044263035080 as (
with aggView1549963716214356602 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40 from aggJoin4823482832909960535 join aggView1549963716214356602 using(v20));
create or replace view aggView2932244701561434677 as select v40, v45 from aggJoin8226513044263035080 group by v40,v45;
create or replace view aggJoin6277979347095861194 as (
with aggView7497415252697481900 as (select v9, MIN(v10) as v57 from aggView6985915702130815654 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7497415252697481900 where mc.company_id=aggView7497415252697481900.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4139303995485729662 as (
with aggView921291555109435222 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView921291555109435222 where mk.keyword_id=aggView921291555109435222.v22);
create or replace view aggJoin6505803761195508817 as (
with aggView1327157151676463759 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin6277979347095861194 join aggView1327157151676463759 using(v16));
create or replace view aggJoin5995234955135064082 as (
with aggView3914853286905436094 as (select v45 from aggJoin4139303995485729662 group by v45)
select v45, v31, v57 as v57 from aggJoin6505803761195508817 join aggView3914853286905436094 using(v45));
create or replace view aggJoin3918159616045422742 as (
with aggView4141210873203766687 as (select v45, MIN(v57) as v57 from aggJoin5995234955135064082 group by v45,v57)
select v45, v46, v57 from aggView9059213845830481616 join aggView4141210873203766687 using(v45));
create or replace view aggJoin7402923823284327385 as (
with aggView7968288199824688493 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin3918159616045422742 group by v45,v57)
select v40, v57, v59 from aggView2932244701561434677 join aggView7968288199824688493 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin7402923823284327385;
