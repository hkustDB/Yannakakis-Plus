create or replace view aggView791420859648414686 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2152040869587177758 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView791420859648414686 where mi_idx.info_type_id=aggView791420859648414686.v1 and info>'2.0';
create or replace view aggView6002654537160488489 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3286492236661614425 as select movie_id as v14 from movie_keyword as mk, aggView6002654537160488489 where mk.keyword_id=aggView6002654537160488489.v3;
create or replace view aggView1798433846549864921 as select v14, MIN(v9) as v26 from aggJoin2152040869587177758 group by v14;
create or replace view aggJoin8826843320860391086 as select v14, v26 from aggJoin3286492236661614425 join aggView1798433846549864921 using(v14);
create or replace view aggView2583961893987196180 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin1726410822549447642 as select v26, v27 from aggJoin8826843320860391086 join aggView2583961893987196180 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1726410822549447642;
