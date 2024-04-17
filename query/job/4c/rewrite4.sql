create or replace view aggView3672280846521479417 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin1947530458535855272 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView3672280846521479417 where mk.movie_id=aggView3672280846521479417.v14;
create or replace view aggView2403423954064539669 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1981904522061986635 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2403423954064539669 where mi_idx.info_type_id=aggView2403423954064539669.v1 and info>'2.0';
create or replace view aggView5230389116642709596 as select v14, MIN(v9) as v26 from aggJoin1981904522061986635 group by v14;
create or replace view aggJoin7542124763521370252 as select v3, v27 as v27, v26 from aggJoin1947530458535855272 join aggView5230389116642709596 using(v14);
create or replace view aggView3878817590024464653 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2739072652072463540 as select v27, v26 from aggJoin7542124763521370252 join aggView3878817590024464653 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2739072652072463540;
