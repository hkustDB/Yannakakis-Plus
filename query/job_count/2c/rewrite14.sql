create or replace view aggView166978423988783625 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7728926863800979716 as select movie_id as v12 from movie_keyword as mk, aggView166978423988783625 where mk.keyword_id=aggView166978423988783625.v18;
create or replace view aggView5090041159253569328 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin362144009832910534 as select movie_id as v12 from movie_companies as mc, aggView5090041159253569328 where mc.company_id=aggView5090041159253569328.v1;
create or replace view aggView8343081485629390977 as select id as v12 from title as t;
create or replace view aggJoin2637356300350320036 as select v12 from aggJoin362144009832910534 join aggView8343081485629390977 using(v12);
create or replace view aggView6884503808034172802 as select v12, COUNT(*) as annot from aggJoin2637356300350320036 group by v12;
create or replace view aggJoin6336014225202182573 as select annot from aggJoin7728926863800979716 join aggView6884503808034172802 using(v12);
select SUM(annot) as v31 from aggJoin6336014225202182573;
