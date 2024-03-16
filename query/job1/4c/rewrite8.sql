create or replace view aggView627078940220695308 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4102378972352360108 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView627078940220695308 where mi_idx.movie_id=aggView627078940220695308.v14 and info>'2.0';
create or replace view aggView8092918554773557181 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7104950902891149698 as select v14, v9, v27 from aggJoin4102378972352360108 join aggView8092918554773557181 using(v1);
create or replace view aggView118627503554316319 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin7104950902891149698 group by v14;
create or replace view aggJoin8587497182866877587 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView118627503554316319 where mk.movie_id=aggView118627503554316319.v14;
create or replace view aggView5080948335053126908 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1590160990277606935 as select v27, v26 from aggJoin8587497182866877587 join aggView5080948335053126908 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1590160990277606935;
