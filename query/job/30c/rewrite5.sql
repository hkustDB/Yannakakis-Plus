create or replace view aggView7596797725037940592 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin2952030056579648173 as (
with aggView1530511941668889248 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1530511941668889248 where mk.keyword_id=aggView1530511941668889248.v20);
create or replace view aggJoin977091972281977136 as (
with aggView5329250056957812550 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5329250056957812550 where cc.status_id=aggView5329250056957812550.v7);
create or replace view aggJoin8119727618916091451 as (
with aggView8068479120497036968 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView8068479120497036968 where mi.info_type_id=aggView8068479120497036968.v16);
create or replace view aggJoin7505258711855553406 as (
with aggView5303885733816078014 as (select v45, v26 from aggJoin8119727618916091451 group by v45,v26)
select v45, v26 from aggView5303885733816078014 where v26 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin4835468848666857600 as (
with aggView2316258454381134482 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin977091972281977136 join aggView2316258454381134482 using(v5));
create or replace view aggJoin5583204494836698545 as (
with aggView4068279866678923160 as (select v45 from aggJoin4835468848666857600 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView4068279866678923160 where mi_idx.movie_id=aggView4068279866678923160.v45);
create or replace view aggJoin3670558757712130229 as (
with aggView4963329929010312829 as (select v45 from aggJoin2952030056579648173 group by v45)
select id as v45, title as v46 from title as t, aggView4963329929010312829 where t.id=aggView4963329929010312829.v45);
create or replace view aggView5380201664916345911 as select v45, v46 from aggJoin3670558757712130229 group by v45,v46;
create or replace view aggJoin180854385053436717 as (
with aggView5335385071478921506 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin5583204494836698545 join aggView5335385071478921506 using(v18));
create or replace view aggView5290478291158900938 as select v45, v31 from aggJoin180854385053436717 group by v45,v31;
create or replace view aggJoin362694755488393347 as (
with aggView1116867327943159223 as (select v45, MIN(v26) as v57 from aggJoin7505258711855553406 group by v45)
select v45, v46, v57 from aggView5380201664916345911 join aggView1116867327943159223 using(v45));
create or replace view aggJoin7903608311980361720 as (
with aggView1371206110532935665 as (select v36, MIN(v37) as v59 from aggView7596797725037940592 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView1371206110532935665 where ci.person_id=aggView1371206110532935665.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8375826274313402160 as (
with aggView3507616776003261379 as (select v45, MIN(v59) as v59 from aggJoin7903608311980361720 group by v45,v59)
select v45, v46, v57 as v57, v59 from aggJoin362694755488393347 join aggView3507616776003261379 using(v45));
create or replace view aggJoin2758138290377051739 as (
with aggView4406980241694248035 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v46) as v60 from aggJoin8375826274313402160 group by v45,v59,v57)
select v31, v57, v59, v60 from aggView5290478291158900938 join aggView4406980241694248035 using(v45));
select MIN(v57) as v57,MIN(v31) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2758138290377051739;
