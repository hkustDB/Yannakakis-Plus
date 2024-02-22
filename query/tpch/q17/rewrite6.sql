create or replace view aggView4604161304104877352 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin5220469165091033411 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5, annot from part as part, aggView4604161304104877352 where part.p_partkey=aggView4604161304104877352.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView7872279541193796768 as select v17, SUM(v28) as v28, SUM(annot) as annot, v5 from aggJoin5220469165091033411 group by v17,v5;
create or replace view aggJoin4435968999038576666 as select v28, annot from view1 as view1, aggView7872279541193796768 where view1.v1_partkey=aggView7872279541193796768.v17 and v5>v1_quantity_avg;
select (SUM(v28) / 7.0) as v29 from aggJoin4435968999038576666;
