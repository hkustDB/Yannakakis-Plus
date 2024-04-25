create or replace view semiJoinView8030378365001875704 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view tAux59 as select id as v15, title as v16, production_year as v19 from title;
create or replace view semiJoinView5598897717236757180 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView7480311129933893343 as select v15, v1, v9 from semiJoinView8030378365001875704 where (v15) in (select (v15) from semiJoinView5598897717236757180);
create or replace view mcAux17 as select v15, v9 from semiJoinView7480311129933893343;
create or replace view semiJoinView5601339090950697862 as select distinct v15, v16, v19 from tAux59 where (v15) in (select (v15) from mcAux17);
create or replace view semiEnum6502312080722791009 as select v9, v19, v16 from semiJoinView5601339090950697862 join mcAux17 using(v15);
select distinct v9, v16, v19 from semiEnum6502312080722791009;
