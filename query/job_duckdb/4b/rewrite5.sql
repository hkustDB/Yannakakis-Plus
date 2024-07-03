create or replace view aggView6302293198992185995 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5937873333640336997 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6302293198992185995 where mi_idx.info_type_id=aggView6302293198992185995.v1 and info>'9.0';
create or replace view aggView6000755762584435686 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin1971165181546386123 as select v14, v9, v27 from aggJoin5937873333640336997 join aggView6000755762584435686 using(v14);
create or replace view aggView3002901473057876659 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin110570746957370063 as select movie_id as v14 from movie_keyword as mk, aggView3002901473057876659 where mk.keyword_id=aggView3002901473057876659.v3;
create or replace view aggView5305588398612258966 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1971165181546386123 group by v14,v27;
create or replace view aggJoin2917826614273457563 as select v27, v26 from aggJoin110570746957370063 join aggView5305588398612258966 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2917826614273457563;
