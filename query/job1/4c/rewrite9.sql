create or replace view aggView4066221390695653403 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin974170159971628657 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4066221390695653403 where mi_idx.info_type_id=aggView4066221390695653403.v1 and info>'2.0';
create or replace view aggView6029032992757329835 as select v14, MIN(v9) as v26 from aggJoin974170159971628657 group by v14;
create or replace view aggJoin4003384800186125724 as select id as v14, title as v15, v26 from title as t, aggView6029032992757329835 where t.id=aggView6029032992757329835.v14 and production_year>1990;
create or replace view aggView6956361525397765402 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3804052601400762815 as select movie_id as v14 from movie_keyword as mk, aggView6956361525397765402 where mk.keyword_id=aggView6956361525397765402.v3;
create or replace view aggView6823424919438231216 as select v14 from aggJoin3804052601400762815 group by v14;
create or replace view aggJoin5175926670181269663 as select v15, v26 as v26 from aggJoin4003384800186125724 join aggView6823424919438231216 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin5175926670181269663;
