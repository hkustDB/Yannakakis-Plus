create or replace view aggView774420640304937685 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin7473715743417474483 as (
with aggView2466513804861768479 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2466513804861768479 where t.kind_id=aggView2466513804861768479.v28 and production_year>2005);
create or replace view aggJoin6526070020391957128 as (
with aggView4841680773675057748 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView4841680773675057748 where mk.keyword_id=aggView4841680773675057748.v25);
create or replace view aggJoin147360071933781393 as (
with aggView6564488798118018754 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6564488798118018754 where mi_idx.info_type_id=aggView6564488798118018754.v23);
create or replace view aggJoin5907067261649063385 as (
with aggView2717867996030111951 as (select v47 from aggJoin6526070020391957128 group by v47)
select v47, v48, v51 from aggJoin7473715743417474483 join aggView2717867996030111951 using(v47));
create or replace view aggView9205334589896689324 as select v47, v48 from aggJoin5907067261649063385 group by v47,v48;
create or replace view aggJoin9057394687458717551 as (
with aggView3057033528243593876 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView3057033528243593876 where cc.status_id=aggView3057033528243593876.v7);
create or replace view aggJoin5507674862809152694 as (
with aggView5204139100540249847 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin9057394687458717551 join aggView5204139100540249847 using(v5));
create or replace view aggJoin9086966062819432593 as (
with aggView7985470532011893304 as (select v47 from aggJoin5507674862809152694 group by v47)
select v47, v33 from aggJoin147360071933781393 join aggView7985470532011893304 using(v47));
create or replace view aggJoin2417247627192838171 as (
with aggView6732138804671764148 as (select v47, v33 from aggJoin9086966062819432593 group by v47,v33)
select v47, v33 from aggView6732138804671764148 where v33>'8.0');
create or replace view aggJoin2387404855829804691 as (
with aggView1861426527372422746 as (select v47, MIN(v48) as v61 from aggView9205334589896689324 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v61 from cast_info as ci, aggView1861426527372422746 where ci.movie_id=aggView1861426527372422746.v47);
create or replace view aggJoin5172471469330314746 as (
with aggView3870741857336054373 as (select v9, MIN(v10) as v59 from aggView774420640304937685 group by v9)
select v38, v47, v61 as v61, v59 from aggJoin2387404855829804691 join aggView3870741857336054373 using(v9));
create or replace view aggJoin338492791393946942 as (
with aggView1830048345450633915 as (select id as v38 from name as n)
select v47, v61, v59 from aggJoin5172471469330314746 join aggView1830048345450633915 using(v38));
create or replace view aggJoin7419256369661053663 as (
with aggView5636474462054420085 as (select v47, MIN(v61) as v61, MIN(v59) as v59 from aggJoin338492791393946942 group by v47,v59,v61)
select v33, v61, v59 from aggJoin2417247627192838171 join aggView5636474462054420085 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin7419256369661053663;
