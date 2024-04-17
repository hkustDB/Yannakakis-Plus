create or replace view aggView1652265537592938094 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin9142753897564942971 as select movie_id as v23, v35 from movie_keyword as mk, aggView1652265537592938094 where mk.keyword_id=aggView1652265537592938094.v8;
create or replace view aggView6142440881668054447 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4573285689821813714 as select movie_id as v23, v36 from cast_info as ci, aggView6142440881668054447 where ci.person_id=aggView6142440881668054447.v14;
create or replace view aggView7515425183402524255 as select v23, MIN(v35) as v35 from aggJoin9142753897564942971 group by v23,v35;
create or replace view aggJoin6305840728172555921 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView7515425183402524255 where t.id=aggView7515425183402524255.v23 and production_year>2000;
create or replace view aggView3763274828907706181 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6305840728172555921 group by v23,v35;
create or replace view aggJoin4309177972368078554 as select v36 as v36, v35, v37 from aggJoin4573285689821813714 join aggView3763274828907706181 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4309177972368078554;
