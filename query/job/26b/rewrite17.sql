create or replace view aggJoin1050783387224529332 as (
with aggView5842129120952249744 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView5842129120952249744 where ci.person_role_id=aggView5842129120952249744.v9);
create or replace view aggJoin7913836629903618400 as (
with aggView7136643883962589181 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView7136643883962589181 where t.kind_id=aggView7136643883962589181.v28 and production_year>2005);
create or replace view aggJoin553981134003349806 as (
with aggView6234677116844690333 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView6234677116844690333 where mk.keyword_id=aggView6234677116844690333.v25);
create or replace view aggJoin7206609528518284238 as (
with aggView1821024783525868344 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1821024783525868344 where mi_idx.info_type_id=aggView1821024783525868344.v23 and info>'8.0');
create or replace view aggJoin7691443909841834657 as (
with aggView7165740951714977880 as (select v47, MIN(v33) as v60 from aggJoin7206609528518284238 group by v47)
select v47, v48, v51, v60 from aggJoin7913836629903618400 join aggView7165740951714977880 using(v47));
create or replace view aggJoin5945311320442700754 as (
with aggView256902788504688415 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin7691443909841834657 group by v47,v60)
select movie_id as v47, subject_id as v5, status_id as v7, v60, v61 from complete_cast as cc, aggView256902788504688415 where cc.movie_id=aggView256902788504688415.v47);
create or replace view aggJoin124572300912460634 as (
with aggView1028835020391033673 as (select v47 from aggJoin553981134003349806 group by v47)
select v38, v47, v59 as v59 from aggJoin1050783387224529332 join aggView1028835020391033673 using(v47));
create or replace view aggJoin8625500953477360175 as (
with aggView2746845680134801120 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5, v60, v61 from aggJoin5945311320442700754 join aggView2746845680134801120 using(v7));
create or replace view aggJoin6704901724195411741 as (
with aggView1969056723158321752 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v60, v61 from aggJoin8625500953477360175 join aggView1969056723158321752 using(v5));
create or replace view aggJoin953094334044857413 as (
with aggView8062448000169924270 as (select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin6704901724195411741 group by v47,v61,v60)
select v38, v59 as v59, v60, v61 from aggJoin124572300912460634 join aggView8062448000169924270 using(v47));
create or replace view aggJoin1337993694507480907 as (
with aggView7279753296339037507 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin953094334044857413 join aggView7279753296339037507 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1337993694507480907;
