create or replace view semiJoinView998416368947739310 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies');
create or replace view semiJoinView9032279639219923988 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view semiJoinView2310756424338910873 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView9032279639219923988);
create or replace view mcAux61 as select v15, v9 from semiJoinView998416368947739310;
create or replace view tAux92 as select v15, v16, v19 from semiJoinView2310756424338910873;
create or replace view semiJoinView2216305650228453714 as select distinct v15, v16, v19 from tAux92 where (v15) in (select (v15) from mcAux61);
create or replace view semiEnum8583256324377174518 as select v9, v19, v16 from semiJoinView2216305650228453714 join mcAux61 using(v15);
select distinct v9, v16, v19 from semiEnum8583256324377174518;
