create or replace view semiJoinView938787546332123168 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view tAux72 as select id as v15, title as v16, production_year as v19 from title where production_year<=2010 and production_year>=2005;
create or replace view semiJoinView3257961131191120613 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (movie_id) in (select (v15) from semiJoinView938787546332123168);
create or replace view semiJoinView1065194791368684741 as select v15, v1, v9 from semiJoinView3257961131191120613 where (v1) in (select (id) from company_type AS ct where kind= 'production companies');
create or replace view mcAux18 as select v15, v9 from semiJoinView1065194791368684741;
create or replace view semiJoinView7258031251094822134 as select distinct v15, v9 from mcAux18 where (v15) in (select (v15) from tAux72);
create or replace view semiEnum1215201996607752928 as select v19, v16, v9 from semiJoinView7258031251094822134 join tAux72 using(v15);
select distinct v9, v16, v19 from semiEnum1215201996607752928;
