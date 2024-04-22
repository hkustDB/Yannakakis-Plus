create or replace view aggJoin5472910478213282029 as (
with aggView7267925535607998202 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView7267925535607998202 where mk.keyword_id=aggView7267925535607998202.v19);
create or replace view aggJoin1683144252431025191 as (
with aggView5966273444894436411 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView5966273444894436411 where mi.info_type_id=aggView5966273444894436411.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6528746205358248114 as (
with aggView9022435506549198540 as (select v49, MIN(v30) as v61 from aggJoin1683144252431025191 group by v49)
select id as v49, title as v50, v61 from title as t, aggView9022435506549198540 where t.id=aggView9022435506549198540.v49);
create or replace view aggJoin286021629940276165 as (
with aggView2061463034800201465 as (select v49, MIN(v61) as v61, MIN(v50) as v64 from aggJoin6528746205358248114 group by v49,v61)
select movie_id as v49, info_type_id as v17, info as v35, v61, v64 from movie_info_idx as mi_idx, aggView2061463034800201465 where mi_idx.movie_id=aggView2061463034800201465.v49);
create or replace view aggJoin6780544000200658522 as (
with aggView3598124105701654915 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35, v61, v64 from aggJoin286021629940276165 join aggView3598124105701654915 using(v17));
create or replace view aggJoin5721077855527677532 as (
with aggView3374404648571891425 as (select v49, MIN(v61) as v61, MIN(v64) as v64, MIN(v35) as v62 from aggJoin6780544000200658522 group by v49,v64,v61)
select v49, v61, v64, v62 from aggJoin5472910478213282029 join aggView3374404648571891425 using(v49));
create or replace view aggJoin8028310962923531540 as (
with aggView1610706372043221982 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView1610706372043221982 where mc.company_id=aggView1610706372043221982.v8);
create or replace view aggJoin2721635833692254321 as (
with aggView2067043844867445390 as (select v49 from aggJoin8028310962923531540 group by v49)
select person_id as v40, movie_id as v49, note as v5 from cast_info as ci, aggView2067043844867445390 where ci.movie_id=aggView2067043844867445390.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2389628436976634363 as (
with aggView6875242280196407602 as (select v49, MIN(v61) as v61, MIN(v64) as v64, MIN(v62) as v62 from aggJoin5721077855527677532 group by v49,v64,v61,v62)
select v40, v5, v61, v64, v62 from aggJoin2721635833692254321 join aggView6875242280196407602 using(v49));
create or replace view aggJoin7306212294135743905 as (
with aggView5498429807915865521 as (select v40, MIN(v61) as v61, MIN(v64) as v64, MIN(v62) as v62 from aggJoin2389628436976634363 group by v40,v64,v61,v62)
select name as v41, v61, v64, v62 from name as n, aggView5498429807915865521 where n.id=aggView5498429807915865521.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin7306212294135743905;
