create or replace view aggView1867747403229877692 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7060343509124578794 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView1867747403229877692 where mi_idx.movie_id=aggView1867747403229877692.v14 and info>'9.0';
create or replace view aggView6184773124623183895 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3378344911615571432 as select movie_id as v14 from movie_keyword as mk, aggView6184773124623183895 where mk.keyword_id=aggView6184773124623183895.v3;
create or replace view aggView7101542307047123465 as select v14 from aggJoin3378344911615571432 group by v14;
create or replace view aggJoin8811060377693128375 as select v1, v9, v27 as v27 from aggJoin7060343509124578794 join aggView7101542307047123465 using(v14);
create or replace view aggView6347418967690286662 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin8811060377693128375 group by v1;
create or replace view aggJoin546597701179587643 as select v27, v26 from info_type as it, aggView6347418967690286662 where it.id=aggView6347418967690286662.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin546597701179587643;
