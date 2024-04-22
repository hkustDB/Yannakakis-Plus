create or replace view aggView1316292867433130149 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1501324009572431353 as (
with aggView2610097801922631186 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2610097801922631186 where t.kind_id=aggView2610097801922631186.v25 and production_year>2005);
create or replace view aggView8037525014804428395 as select v46, v45 from aggJoin1501324009572431353 group by v46,v45;
create or replace view aggJoin423408319722397456 as (
with aggView4071685723386339737 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4071685723386339737 where mi_idx.info_type_id=aggView4071685723386339737.v20);
create or replace view aggJoin8083775141353845153 as (
with aggView7993784244109050067 as (select v40, v45 from aggJoin423408319722397456 group by v40,v45)
select v45, v40 from aggView7993784244109050067 where v40<'8.5');
create or replace view aggJoin4368141997629441243 as (
with aggView1217881334744973944 as (select v9, MIN(v10) as v57 from aggView1316292867433130149 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1217881334744973944 where mc.company_id=aggView1217881334744973944.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4672701292617239878 as (
with aggView5162474857808601609 as (select v45, MIN(v40) as v58 from aggJoin8083775141353845153 group by v45)
select v45, v16, v31, v57 as v57, v58 from aggJoin4368141997629441243 join aggView5162474857808601609 using(v45));
create or replace view aggJoin128962811670172858 as (
with aggView5012770662924513740 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5012770662924513740 where cc.subject_id=aggView5012770662924513740.v5);
create or replace view aggJoin8188387855525455901 as (
with aggView8264577593985543278 as (select id as v16 from company_type as ct)
select v45, v31, v57, v58 from aggJoin4672701292617239878 join aggView8264577593985543278 using(v16));
create or replace view aggJoin2250188842656160755 as (
with aggView2175240592156894996 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin128962811670172858 join aggView2175240592156894996 using(v7));
create or replace view aggJoin8542101010343576136 as (
with aggView2847050332211737560 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2847050332211737560 where mk.keyword_id=aggView2847050332211737560.v22);
create or replace view aggJoin9131291550844927409 as (
with aggView899385295529659892 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView899385295529659892 where mi.info_type_id=aggView899385295529659892.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8172491548935576488 as (
with aggView6001824935758712613 as (select v45 from aggJoin9131291550844927409 group by v45)
select v45 from aggJoin8542101010343576136 join aggView6001824935758712613 using(v45));
create or replace view aggJoin2976087097870244419 as (
with aggView7481587330301897007 as (select v45 from aggJoin8172491548935576488 group by v45)
select v45 from aggJoin2250188842656160755 join aggView7481587330301897007 using(v45));
create or replace view aggJoin6502380631738940067 as (
with aggView5345164681304792296 as (select v45 from aggJoin2976087097870244419 group by v45)
select v45, v31, v57 as v57, v58 as v58 from aggJoin8188387855525455901 join aggView5345164681304792296 using(v45));
create or replace view aggJoin2789344809375775373 as (
with aggView5647347514772528415 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin6502380631738940067 group by v45,v57,v58)
select v46, v57, v58 from aggView8037525014804428395 join aggView5647347514772528415 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin2789344809375775373;
