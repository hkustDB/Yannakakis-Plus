create or replace view aggView8368644567355562073 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin177377144446680198 as select movie_id as v12 from movie_companies as mc, aggView8368644567355562073 where mc.company_id=aggView8368644567355562073.v1;
create or replace view aggView997173633165431416 as select v12, COUNT(*) as annot from aggJoin177377144446680198 group by v12;
create or replace view aggJoin8148451510284323348 as select id as v12, annot from title as t, aggView997173633165431416 where t.id=aggView997173633165431416.v12;
create or replace view aggView2303339709390079672 as select v12, SUM(annot) as annot from aggJoin8148451510284323348 group by v12;
create or replace view aggJoin425495679021379973 as select keyword_id as v18, annot from movie_keyword as mk, aggView2303339709390079672 where mk.movie_id=aggView2303339709390079672.v12;
create or replace view aggView588902073171628244 as select v18, SUM(annot) as annot from aggJoin425495679021379973 group by v18;
create or replace view aggJoin2719992433782501516 as select keyword as v9, annot from keyword as k, aggView588902073171628244 where k.id=aggView588902073171628244.v18 and keyword= 'character-name-in-title';
select SUM(annot) as v31 from aggJoin2719992433782501516;
