create or replace view aggJoin3790502090289466827 as (
with aggView6645241927732699725 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6645241927732699725 where ci.person_role_id=aggView6645241927732699725.v9);
create or replace view aggJoin4825368609897951368 as (
with aggView4612421695875248624 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4612421695875248624 where t.kind_id=aggView4612421695875248624.v28 and production_year>2005);
create or replace view aggJoin5620173644474119397 as (
with aggView635929773665602167 as (select v47, MIN(v48) as v61 from aggJoin4825368609897951368 group by v47)
select v38, v47, v59 as v59, v61 from aggJoin3790502090289466827 join aggView635929773665602167 using(v47));
create or replace view aggJoin8857952754584476767 as (
with aggView5748661003478489897 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView5748661003478489897 where mk.keyword_id=aggView5748661003478489897.v25);
create or replace view aggJoin7035880669823027866 as (
with aggView4094280717703370572 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4094280717703370572 where mi_idx.info_type_id=aggView4094280717703370572.v23 and info>'8.0');
create or replace view aggJoin4060884614962842465 as (
with aggView6793953290414394779 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView6793953290414394779 where cc.status_id=aggView6793953290414394779.v7);
create or replace view aggJoin9083243687101749280 as (
with aggView5172325528572934233 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin4060884614962842465 join aggView5172325528572934233 using(v5));
create or replace view aggJoin5012687050009262887 as (
with aggView2152481293574348667 as (select v47 from aggJoin8857952754584476767 group by v47)
select v47, v33 from aggJoin7035880669823027866 join aggView2152481293574348667 using(v47));
create or replace view aggJoin6324142910600309811 as (
with aggView1378921746299881254 as (select v47, MIN(v33) as v60 from aggJoin5012687050009262887 group by v47)
select v47, v60 from aggJoin9083243687101749280 join aggView1378921746299881254 using(v47));
create or replace view aggJoin6523915342649508431 as (
with aggView8022030193080574412 as (select v47, MIN(v60) as v60 from aggJoin6324142910600309811 group by v47,v60)
select v38, v59 as v59, v61 as v61, v60 from aggJoin5620173644474119397 join aggView8022030193080574412 using(v47));
create or replace view aggJoin4853603328299632408 as (
with aggView2804767882592816014 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin6523915342649508431 join aggView2804767882592816014 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4853603328299632408;
