create or replace view tAux10 as select id as v14, title as v15 from title where production_year>1990;
create or replace view semiJoinView3640885737685846727 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView1095369397880334765 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (movie_id) in (select (v14) from semiJoinView3640885737685846727);
create or replace view semiJoinView5726851929396222491 as select v14, v1, v9 from semiJoinView1095369397880334765 where (v1) in (select (id) from info_type AS it where info= 'rating');
create or replace view mi_idxAux80 as select v14, v9 from semiJoinView5726851929396222491;
create or replace view semiJoinView8444328226253890649 as select distinct v14, v9 from mi_idxAux80 where (v14) in (select (v14) from tAux10);
create or replace view semiEnum9161754830955804317 as select v15, v9 from semiJoinView8444328226253890649 join tAux10 using(v14);
select distinct v9, v15 from semiEnum9161754830955804317;
