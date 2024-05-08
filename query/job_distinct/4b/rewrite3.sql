create or replace view semiJoinView5463231450276085063 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView3686494841157407231 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView5463231450276085063) and production_year>2010;
create or replace view tAux4 as select v14, v15 from semiJoinView3686494841157407231;
create or replace view semiJoinView9094425760506657243 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view mi_idxAux53 as select v14, v9 from semiJoinView9094425760506657243;
create or replace view semiJoinView3635445954101619727 as select distinct v14, v15 from tAux4 where (v14) in (select (v14) from mi_idxAux53);
create or replace view semiEnum8072148073450779248 as select v9, v15 from semiJoinView3635445954101619727 join mi_idxAux53 using(v14);
select distinct v9, v15 from semiEnum8072148073450779248;
