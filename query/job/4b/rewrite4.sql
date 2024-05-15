create or replace view aggView7382487710234507830 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5003821203008146244 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7382487710234507830 where mi_idx.info_type_id=aggView7382487710234507830.v1 and info>'9.0';
create or replace view aggView5566878143538331277 as select v14, MIN(v9) as v26 from aggJoin5003821203008146244 group by v14;
create or replace view aggJoin5139099567546157675 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView5566878143538331277 where t.id=aggView5566878143538331277.v14 and production_year>2010;
create or replace view aggView1679183450939422410 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5216048045036325406 as select movie_id as v14 from movie_keyword as mk, aggView1679183450939422410 where mk.keyword_id=aggView1679183450939422410.v3;
create or replace view aggView2039239905739914222 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5139099567546157675 group by v14;
create or replace view aggJoin1031611648050607472 as select v26, v27 from aggJoin5216048045036325406 join aggView2039239905739914222 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1031611648050607472;
